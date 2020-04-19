############################################################################
##                                message                                 ##
############################################################################
function fish_greeting
    echo ""
end
############################################################################


############################################################################
##                                  Alias                                 ##
############################################################################
alias vim "nvim"
alias exa "exa --icons"
alias ls "exa"
alias cat "bat"
alias od "hexyl" # odはバイナリダンプコマンド
alias find "fd"
alias ps "procs"
alias grep "rg"
alias comproide "tmux source-file ~/Documents/tmux-layout"
alias g++ "g++ -Wall -Wextra -pedantic -std=c++17 -O2 -Wshadow -Wformat=2 -Wfloat-equal -Wconversion -Wlogical-op -Wshift-overflow=2 -Wduplicated-cond -Wcast-qual -Wcast-align -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -D_FORTIFY_SOURCE=2 -fsanitize=address -fsanitize=undefined -fno-sanitize-recover -fstack-protector"
############################################################################


############################################################################
##                              cd + ls にする                            ##
############################################################################
function cd
    if test (count $argv) -eq 0
        builtin cd
    else if test (count $argv) -gt 1
        printf "%s\n" (_ "Too many args for cd command")
        return 1
    end
    # Avoid set completions.
    set -l previous $PWD

    if test "$argv" = "-"
        if test "$__fish_cd_direction" = "next"
            nextd
        else
            prevd
        end
        return $status
    end
    builtin cd $argv
    set -l cd_status $status
    # Log history
    if test $cd_status -eq 0 -a "$PWD" != "$previous"
        set -q dirprev[$MAX_DIR_HIST]
        and set -e dirprev[1]
        set -g dirprev $dirprev $previous
        set -e dirnext
        set -g __fish_cd_direction prev
    end

    if test $cd_status -ne 0
        return 1
    end
    ls
    return $status
end
############################################################################



############################################################################
##                      auto launch tmux function                         ##
############################################################################
function attach_tmux_session_if_needed
    set ID (tmux list-sessions)
    if test -z "$ID"
        tmux new-session
        return
    end

    set new_session "Create New Session" 
    set ID (echo $ID\n$new_session | peco --on-cancel=error | cut -d: -f1)
    if test "$ID" = "$new_session"
        tmux new-session
    else if test -n "$ID"
        tmux attach-session -t "$ID"
    end
end

############################################################################



############################################################################
##                                  fisher                                ##
############################################################################

# fzf あいまい検索
# 古いキーバインドを無効にする
set -U FZF_LEGACY_KEYBINDINGS 0
############################################################################


############################################################################
##                                starship                                ##
############################################################################

eval (starship init fish)

############################################################################



############################################################################
##                      auto launch tmux function                         ##
############################################################################
if test -z $TMUX
    attach_tmux_session_if_needed
end
############################################################################
