package br.edu.ucb.webdatamodeling.tree
{
	import mx.collections.ArrayCollection;
	
	public class FolderNode extends FileSystemNode
	{
		[Bindable]
		internal var Items:ArrayCollection = new ArrayCollection();
	}
}