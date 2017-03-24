vimfx.set('hints.chars', 'asdfghjklwerqcnm')

vimfx.addKeyOverrides(
	[ location => location.hostname === 'google.com',
		[
			'1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
			'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p',
			'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l',
			'z', 'x', 'c', 'v', 'b', 'n', 'm'
		]
	]
)
vimfx.addKeyOverrides(
	[ location => location.hostname === 'mail.google.com',
		[
			'!', '#', '*', '.', '/', ':', ';', '?',
			'A', 'F', 'I', 'N', 'R', 'U', '_',
			'[', ']', '{', '}',
			'a', 'b', 'c', 'd', 'e', 'f', 'g', 'i', 'j', 'k', 'l', 'm',
			'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'x', 'y', 'z'
		]
	]
)
vimfx.addKeyOverrides(
	[ location => location.hostname === 'inbox.google.com',
		[
			'c', '/', 'i', 'q', 'h', 't', 'B', 'M', 'z', 'o', 'u', 'j', 'k', 'n', 'p', 'e', 'y', '[', ']', 's', 'P', 'a', 'A', 'r', 'R', 'f', '#', '!', 'm', '.', 'x', 'X', '?'
		]
	]
)
vimfx.addKeyOverrides(
	[ location => location.hostname === 'calendar.google.com',
		[
			'k', 'p', 'j', 'n', 'r', 't', '1', 'd', '2', 'w', '3', 'm', '4', 'x', '5', 'a', 'c', 'e', 'z', '/', '+', 'q', 'C', 's', '?'
		]
	]
)
vimfx.addKeyOverrides(
	[ location => location.hostname === 'drive.google.com',
		[
			//navigation and views
			'g', 'n', 'f', 'i', 'd', 't', 'u', 'v', 'd', 'i',
			//Select Items
			'x', 'j', '<Down>', 'k', '<Up>', 'h', '<left>', 'l', '<Right>', '<S-Down>', '<S-Up>', '<S-Left>', '<S-Right>', 'A', 'N',
			//Move between items
			'<C-Down>', '<C-Up>', '<C-Left>', '<C-Right>',
			//Take Action on selected items
			'o','<CR>', 'n', '.', 'z', 's', 'Shift + z', '#', '<C-z>', '<C-S-z>',
			//Create new items
			'T', 'P', 'S', 'D', 'F', 'O',
			//Open menus
			'c', 'a', 'f', 'r', 't',
			//Application actions
			'?', 'q', '<C-f>', '<C-p>', 'm', '/',
			//Preview mode actions
			'<Esc>', '<Space>', '+', '=', '-'
		]
	]
)
vimfx.addKeyOverrides(
	[ location => location.hostname === 'keep.google.com',
		[
			'j',
			'k',
			'n',
			'p',
			'c',
			'l',
			'/',
			'<C-a>',
			'?',
			'@',
			'e',
			'#',
			'x',
			'<C-g>'
		]
	]
)
vimfx.addKeyOverrides(
	[ location => location.hostname === 'contacts.google.com',
		[
			'?', '/', '@', 'j', 'k', 'z', 'x', '<C-A>', '<CR>', 'm'
		]
	]
)
vimfx.addKeyOverrides(
	[ location =>  (location.hostname === 'www.youtube.com' || location.hostname === 'gaming.youtube.com') && location.pathname === '/watch',
		[
			'N', 'P', 'l', 'j', 'k', '/', 'f',
			'1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
			'.', ',', '+', '-'
		]
	]
)
vimfx.addKeyOverrides(
	[ location => location.hostname === 'www.google.com' &&	location.pathname === '/contacts/',
		[
			'/',
			'k',
			'j',
			'o',
			'u',
			'e',
			'x',
			'<C-s>',
			'#',
			'l',
			'z',
			'.',
			'?',
			'g',
			'c',
			'*',
			'a',
			'*',
			'n'
		]
	]
)
vimfx.addKeyOverrides(
	[ location => location.hostname === 'plus.google.com',
		[
			'j', 'k', '/', '\\', '>', '<', 'n', 'p', 'c', 'f', 's', 'v', '+', '@', '?'
		]
	]
)
vimfx.addKeyOverrides(
	[ location => location.hostname === 'www.facebook.com',
		[
			'1', '2', '3', '4', '5', '6', '7', '8', '9', 'j', 'k', 'o', 'l', 'c', 's', 'o', '/', 'q', '?'
		]
	]
)
vimfx.addKeyOverrides(
	[ location => location.hostname === 'twitter.com',
		[
			'?', 'n', 'l', 'r', 't', 'm', 'u', 'b', 'o', '/', 'j', 'k', '.', 'g', 'h', 'n', 'r', 'p', 'l', 'i', 'm', 's', 'u'
		]
	]
)
vimfx.addKeyOverrides(
	[ location => location.hostname === 'classroom.udacity.com',
		[
			'j', 'k', 'l', '.'
		]
	]
)
vimfx.addKeyOverrides(
	[ location => location.hostname === 'developer.android.com',
		[
			'/'
		]
	]
)
vimfx.addKeyOverrides(
	[ location => location.hostname === 'keycode.info',
		[
			'/'
		]
	]
)
vimfx.addKeyOverrides(
	[ location => location.hostname === 'www.dropbox.com',
		[
			'?', '/'
		]
	]
)
vimfx.addKeyOverrides(
	[ location => location.hostname === 'github.com',
		[
			's', 'g', 'n', '?', 'd', 'j', 'k', 'x', 'o', '<CR>'
		]
	]
)
vimfx.addKeyOverrides(
	[ location => location.hostname === 'github.com' && location.pathname.includes('blob') === true,
		[
			't', 'l', 'w', 'y', 'i'
		]
	]
)
vimfx.addKeyOverrides(
	[ location => location.hostname === 'github.com' && location.pathname === '/tpope/vim-speeddating/issues',
		[
			'c', 'u', 'l', 'm', 'a', 'r', 'o'
		]
	]
)
vimfx.addKeyOverrides(
	[ location => location.hostname === 'github.com' && location.pathname.includes('pull') === true,
		[
			'c', '/', 'u', 'l', 'm', 'a', 'r', 'o'
		]
	]
)
