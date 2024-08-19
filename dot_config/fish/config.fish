if status is-interactive
    # Commands to run in interactive sessions can go here
	atuin init fish | source
	direnv hook fish | source
	set -Ux fifc_editor nvim
end
