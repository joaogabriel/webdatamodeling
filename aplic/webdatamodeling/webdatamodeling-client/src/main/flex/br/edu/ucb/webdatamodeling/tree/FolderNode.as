package br.edu.ucb.webdatamodeling.tree
{
	import mx.collections.ArrayCollection;
	
	public class FolderNode extends FileSystemNode
	{
		[Bindable]
		public var items:ArrayCollection = new ArrayCollection();
	}
}