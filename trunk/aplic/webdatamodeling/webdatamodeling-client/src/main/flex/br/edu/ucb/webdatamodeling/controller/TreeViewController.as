package br.edu.ucb.webdatamodeling.controller
{
	import br.edu.ucb.webdatamodeling.dto.CampoDTO;
	import br.edu.ucb.webdatamodeling.dto.TabelaDTO;
	import br.edu.ucb.webdatamodeling.tree.FileNode;
	import br.edu.ucb.webdatamodeling.tree.FolderNode;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.controls.Tree;
	import mx.events.TreeEvent;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	public class TreeViewController
	{
		[Bindable]
		public var files:ArrayCollection;
	
		private var _view:Tree;
		
		private var fileSystemService:RemoteObject;
		
		public function TreeViewController(view:Tree)
		{
			_view = view;
		}
		
		public function init():void
		{
			var node1:FileNode = new FileNode();
			node1.size = 5;
			node1.Name = "nó 1";
			node1.fullName = "";
			node1.createdOn = new Date();
			node1.lastAccessedOn = new Date();
			node1.lastWrittenOn = new Date();

			var folder2:FolderNode = new FolderNode();
			folder2.Name = "Pasta 2";
			
			var folder1:FolderNode = new FolderNode();
			folder1.Name = "Pasta 1";
			folder1.items.addItem(node1);
			folder1.items.addItem(folder2);
			
			files = new ArrayCollection();
			files.addItem(folder1);
		}
		
		private function processRootStructure( result:ResultEvent ):void
		{
			if (result == null) {
				files = new ArrayCollection();
				files.addItem(new FileNode());
			} else {
				files = new ArrayCollection( result.result as Array );
			}					
		}
		
		private function gotError( fault:FaultEvent ):void
		{
			Alert.show( "Server reported an error - " + fault.fault.faultString );
		}
		
		public function handleTreeChange( event:Event ):void
		{
			var selectedItem:Object = Tree( event.target ).selectedItem;
			
			if( selectedItem is FolderNode )
				fetchFolderInfo( FolderNode( selectedItem ) );
		}
		
		public function handleRetrieve( event:TreeEvent ):void
		{
			if( event.item is FolderNode && event.opening )
				fetchFolderInfo( FolderNode( event.item ) );
		}
		
		private function fetchFolderInfo( folder:FolderNode ):void
		{
			if( folder.items.length != 0 )
				return;
				
			var asyncToken:AsyncToken = fileSystemService.getDirectory( folder.fullName );
			
			asyncToken.addResponder( new mx.rpc.Responder(
                function( event:ResultEvent ):void
                {
                	folder.items = new ArrayCollection( event.result as Array );
                	_view.validateNow();
                	_view.expandItem( folder, true );	                	
                },
                function( fault:FaultEvent):void
                {
                	gotError( fault );
                }
            ));				
		}

	}
}