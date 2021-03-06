testing
testSimple
	| smalltalkCI path |
	path := '/dir/to/project' copyReplaceAll: '/' with: SmalltalkCI pathNameDelimiter.
	smalltalkCI := SmalltalkCI basicNew initialize.
	smalltalkCI projectDirectory: path.
	self assert: '' equals: self spec directory.
	self assert: #() equals: self spec load.
	self deny: self spec onWarningLog.
	self deny: self spec useLatestMetacello.

	self spec
		directory: 'foodir';
		load: #('FooLoad');
		version: '1.2.3';
		onWarningLog: true;
		useLatestMetacello: false.
	
	self
		assert: 'foodir' equals: self spec directory;
		assert: 'FooLoad' equals: self spec load first;
		assert: '1.2.3' equals: self spec version;
		assert: self spec onWarningLog;
		deny: self spec useLatestMetacello;
		assert: ('filetree://', path, SmalltalkCI pathNameDelimiter, 'foodir')
			equals: (self spec repositoryUrlIn: smalltalkCI projectDirectory).
		
	self spec repository: 'repo'.	
	self assert: 'repo' equals: (self spec repository)
