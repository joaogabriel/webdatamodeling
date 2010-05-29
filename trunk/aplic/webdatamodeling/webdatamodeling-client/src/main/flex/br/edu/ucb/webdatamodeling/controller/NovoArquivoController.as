package br.edu.ucb.webdatamodeling.controller
{
	import br.edu.ucb.webdatamodeling.components.NovoArquivo;
	import br.edu.ucb.webdatamodeling.dto.ArquivoDTO;
	import br.edu.ucb.webdatamodeling.dto.PastaDTO;
	import br.edu.ucb.webdatamodeling.events.CustomEvent;
	import br.edu.ucb.webdatamodeling.service.ArquivoService;
	import br.edu.ucb.webdatamodeling.service.PastaService;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.controls.Menu;
	import mx.controls.Tree;
	import mx.events.MenuEvent;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	public class NovoArquivoController extends EventDispatcher
	{
		public static const UPDATE_TREE:String = "updateTree";
		
		private var _view:NovoArquivo;
		private var _menuData:Object;
		private var _menuButton:Menu;
		
		private var _tree:Tree;
		
		private static const INDEX_ARQUIVO:String = "index_arquivo";
		private static const INDEX_PASTA:String = "index_pasta";
		
		private var _arquivoService:ArquivoService = ArquivoService.getInstance();
		private var _pastaService:PastaService = PastaService.getInstance();
		
		private var _resourceManager:IResourceManager = ResourceManager.getInstance();
		
		public function NovoArquivoController(view:NovoArquivo)
		{
			_view = view;
		}
		
		public function inserirArquivo(event:MouseEvent):void
		{
			var arquivo:ArquivoDTO;
			var pasta:PastaDTO;
			var nomeArquivo:String = _view.txtNomeArquivo.text;
			
			if (nomeArquivo == null) {
				// vir do arquivo de mensagens
				Alert.show("É necessário informar um nome.");
				return;
			}
			
			if (_view.btnTipoArquivo.aux.toString() == INDEX_ARQUIVO) {
				if (_tree.selectedItem is PastaDTO) {
					arquivo = new ArquivoDTO();
					arquivo.nome = nomeArquivo;
					arquivo.pasta = _tree.selectedItem as PastaDTO;
					
					_arquivoService.insert(arquivo);
				} else {
					// vir do arquivo de mensagens
					Alert.show("É necessário selecionar uma pasta.");
				}
			} else if (_view.btnTipoArquivo.aux.toString() == INDEX_PASTA) {
				pasta = new PastaDTO();
				pasta.nome = nomeArquivo;
				
				//_pastaService.addEventListener(insert, exibirMensagem);
				_pastaService.insert(pasta);
			}
			_pastaService.addEventListener("insert", insertHandler);
			_arquivoService.addEventListener("insert", insertHandler);
		}
		
		private function insertHandler(event:Event):void
		{
			_tree.dispatchEvent(new Event(UPDATE_TREE));
		}
		
		private function exibirMensagem(event:CustomEvent):void
		{
			
		}
		
		public function initMenu():void
		{
			// inicia o data provider de acordo com o locale
			initMenuData();
			
			_menuButton = new Menu();
			_menuButton.dataProvider = _menuData;
			_menuButton.selectedIndex = 0;       
			_menuButton.addEventListener("itemClick", itemClickHandler);
			
			_view.btnTipoArquivo.popUp = _menuButton;
			_view.btnTipoArquivo.aux = _menuButton.dataProvider[_menuButton.selectedIndex].index;
			_view.btnTipoArquivo.label = _menuButton.dataProvider[_menuButton.selectedIndex].label;
			
			_view.imagem.source = "assets/images/add_file_icon.png";
		}
		
		private function initMenuData():void
		{
			_menuData = [{
							index: INDEX_ARQUIVO,
							label: _resourceManager.getString('messages', 'arquivo.cadastro')
						},
						{
							index: INDEX_PASTA,
							label: _resourceManager.getString('messages', 'pasta.cadastro')
						}];
		}
		
		private function itemClickHandler(event:MenuEvent):void
		{
			var index:String = event.item.index;
			var label:String = event.item.label;
			
			if (index == INDEX_ARQUIVO) {
				_view.imagem.source = "assets/images/add_file_icon.png";
			} else if (index == INDEX_PASTA) {
				_view.imagem.source = "assets/images/add_folder_icon.png";
			}
			
			_view.btnTipoArquivo.aux = index;
			_view.btnTipoArquivo.label = label;
			_view.btnTipoArquivo.close();
			_menuButton.selectedIndex = event.index;
		}
		
		public function set tree(tree:Tree):void
		{
			_tree = tree;
		}
	}
}