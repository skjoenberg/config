#!/usr/local/bin/bb

(ns bspwmrc
  (:require
   [clojure.java.shell :as shell]
   [clojure.string :as string]))

(defn run-sh [command]
  (shell/with-sh-dir "/home/sebastian"
    (shell/sh "bash" "-c" command)))

(defn run-sh-in-background [command]
  (future (run-sh command)))

(defn is-running? [application]
  (->> (shell/sh "ps" "aux")
       (:out)
       (re-find (re-pattern application))
       (seq)))

(defn run-if-not-running [application]
  (when-not (is-running? application)
    (run-sh-in-background application)))

(def workspaces-main
  ["www" "mail" "editor" "communication" "terminal" "random"])

(def startup-applications
  [;"slack"
   "brave-browser"
   "gnome-terminal"])

(def configuration-commands
  ["wmname LG3D"
   "xset r rate 190 35"
   "feh --bg-fill Pictures/bg.jpg"
   ;"polybar -c ~/config/polybar/config example"
   "setxkbmap us -option ctrl:nocaps"])

(defn get-monitor-amount []
  (->> (shell/sh "xrandr" "--listmonitors")
       (:out)
       (string/split-lines)
       (first)
       (re-find #"Monitors: (\d+)")
       (last)
       (Integer/parseInt)))

(defn setup-screen [monitor-id workspaces]
  (run-sh (format "bspc monitor %s -d %s" monitor-id (reduce #(format "%s %s" %1 %2) workspaces))))

(defn set-rule [application workspace]
  (println application workspace)
  (run-sh (format "bspc rule -a %s desktop='%s'" application workspace)))

(defn setup-rules []
  (doall (map (partial apply set-rule)
       [["Brave-browser" "www"]
        ["Prospect Mail" "mail"]
        ["Microsoft Teams - preview" "communication"]
        ["Thunderbird" "mail"]
        ["Code" "editor"]
        ["Spotify" "random"]
        ["Slack" "communication"]
        ["Signal" "communication"]
        ["Gnome-terminal" "terminal"]
        ["Termite" "terminal"]])))

(defn setup-monitors []
  (case (get-monitor-amount) 
    1 (do (setup-screen "eDP-1" workspaces-main)
          (run-sh-in-background "polybar -c config/polybar/config example2"))
    2 (do (run-sh "xrandr --output eDP-1 --below DP-1")
          (run-sh-in-background "polybar -c config/polybar/config example")
          (setup-screen "DP-1" workspaces-main)
          (setup-screen "eDP-1" ["whatever"]))
    3 (do (run-sh "xrandr --output DP-2 --right-of HDMI-1")
        (run-sh "xrandr --output eDP-1 --below DP-2")
        (setup-screen "DP-2" workspaces-main)
        (setup-screen "HDMI-1" ["whatever"])
        (setup-screen "eDP-1" ["whatevertwo"])
        (run-sh-in-background "polybar -c config/polybar/config example"))))

(defn start-sxhkd []
  (run-sh "(killall -9 sxhkd) || true")
  (run-sh "sxhkd -c /home/sebastian/config/sxhkd/sxhkdrc"))

(defn main- []
  (setup-monitors)
  (setup-rules)
  (doall (map run-if-not-running startup-applications))
  (doall (map run-sh configuration-commands))
  (start-sxhkd))

(main-)
