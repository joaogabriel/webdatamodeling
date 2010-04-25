package br.edu.ucb.webdatamodeling.tree
{
	import mx.controls.treeClasses.ITreeDataDescriptor;
	import mx.collections.ICollectionView;
	import mx.collections.ArrayCollection;
	
	public class FileSystemTreeDataDescriptor implements ITreeDataDescriptor
	{
		public function getData(node:Object, model:Object=null):Object
		{
			return node;
		}
		
		public function hasChildren(node:Object, model:Object=null):Boolean
		{
		   return node is FolderNode;
		}
		
		public function addChildAt(parent:Object, newChild:Object, index:int, model:Object=null):Boolean
		{
			return false;
		}
		
		public function isBranch(node:Object, model:Object=null):Boolean
		{
			return !(node is FileNode) && hasChildren(node);
		}
		
		public function removeChildAt(parent:Object, child:Object, index:int, model:Object=null):Boolean
		{
			//FileSystemNode(parent).Items.slice(index,index);
			
			return false;
		}
		
		public function getChildren(node:Object, model:Object=null):ICollectionView
		{
			return FolderNode(node).Items;
		}		
	}
} 