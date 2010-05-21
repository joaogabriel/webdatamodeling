package br.edu.ucb.webdatamodeling.controller
{
	import br.edu.ucb.webdatamodeling.dto.PastaDTO;
	import br.edu.ucb.webdatamodeling.events.CustomEvent;
	import br.edu.ucb.webdatamodeling.service.PastaService;
	import br.edu.ucb.webdatamodeling.service.UsuarioService;
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
	
	public class TreeViewController
	{
		[Bindable]
		private var _files:ArrayCollection;
	
		private var _view:Tree;
		
		private var _pastaService:PastaService = PastaService.getInstance();
		
		private var _usuarioService:UsuarioService = UsuarioService.getInstance();
		
		public function get files():ArrayCollection
		{
			return _files;
		}
		public function TreeViewController(view:Tree)
		{
			_view = view;
		}
		
		public function init():void
		{
			/* var node1:FileNode = new FileNode();
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
			files.addItem(folder1); */
			_usuarioService.addEventListener("login", initHandler);
		}
		
		public function initHandler(event:CustomEvent):void
		{
			_pastaService.addEventListener("getPastas", processRootStructure);
			_pastaService.getPastasByUsuarioAutenticado();
		}
		
		private function processRootStructure(result:CustomEvent):void
		{
			if (result == null) {
				_files = new ArrayCollection();
				_files.addItem(new FileNode());
			} else {
				_files = result.data;
			}					
		}
		
		private function gotError(fault:FaultEvent):void
		{
			Alert.show("Server reported an error - " + fault.fault.faultString);
		}
		
		public function handleTreeChange( event:Event ):void
		{
			var selectedItem:Object = Tree(event.target).selectedItem;
			
			if (selectedItem is PastaDTO) {
				fetchFolderInfo(PastaDTO(selectedItem));
			}
		}
		
		public function handleRetrieve(event:TreeEvent):void
		{
			if (event.item is FolderNode && event.opening) {
				fetchFolderInfo(PastaDTO(event.item));
			}
		}
		
		private function fetchFolderInfo(folder:PastaDTO):void
		{
			if (folder.arquivos.length != 0) {
				return;
			}
			
			// escrever service	
			var asyncToken:AsyncToken = null;//fileSystemService.getDirectory( folder.fullName );
			
			asyncToken.addResponder( new mx.rpc.Responder(
                function( event:ResultEvent ):void
                {
                	folder.arquivos = new ArrayCollection(event.result as Array);
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