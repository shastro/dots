if status is-interactive
    # Commands to run in interactive sessions can go here
    set -gx PATH $PATH ~/bin
    set -gx PATH $PATH ~/scripts
    set -gx PATH $PATH /usr/local/go/bin
    set -gx PATH $PATH ~/.cargo/bin
    set -gx PATH $PATH ~/installdump/arduino-language-server
    if [ "$TERM" = "xterm-kitty" ]
        export TERM=xterm
    end
    abbr --set lf lfcd
    abbr --set monright xrandr --output DP-0 --right-of DP-2 --auto
    abbr --set monleft xrandr --output DP-0 --left-of DP-2 --auto
    abbr --set monsame xrandr --output DP-0 --same-as DP-2 --auto
    set -gx EDITOR hx
    set -gx SHELL fish

    set -gx LIBVA_DRIVER_NAME vdpau

    set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket.
end

set -g fish_greeting

starship init fish | source

