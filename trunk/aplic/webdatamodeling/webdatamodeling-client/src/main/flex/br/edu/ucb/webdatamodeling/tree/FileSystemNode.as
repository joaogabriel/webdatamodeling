package br.edu.ucb.webdatamodeling.tree
{
	public class FileSystemNode
	{
		[Bindable]
		public var Name:String;
		
		public var fullName:String;
		public var createdOn:Date;
		public var lastAccessedOn:Date;
		public var lastWrittenOn:Date;
	}
}