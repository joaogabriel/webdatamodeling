package br.edu.ucb.webdatamodeling.controller
{
	import br.edu.ucb.webdatamodeling.components.CompartilharMER;
	import br.edu.ucb.webdatamodeling.dto.UsuarioDTO;
	import br.edu.ucb.webdatamodeling.events.CustomEvent;
	import br.edu.ucb.webdatamodeling.service.UsuarioService;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	import mx.managers.PopUpManager;
	
	public class CompartilharMERController
	{
		private var _usuarioService:UsuarioService = UsuarioService.getInstance();
		
		private var _view:CompartilharMER;
		
		[Bindable]
		private var _usuariosCompartilhados:ArrayCollection;
		
		[Bindable]
		private var _usuariosPesquisados:ArrayCollection;
		
		public function CompartilharMERController(view:CompartilharMER)
		{
			_view = view;
			
			_usuarioService.addEventListener("findAll", findUsuariosCompartilhados);
			_usuarioService.findAll();
		}
		
		private function findUsuariosCompartilhados(event:CustomEvent):void
		{
			_usuariosCompartilhados = event.data;
			_view.tblCompartilhados.dataProvider = _usuariosCompartilhados;
		}
		
		public function buscar():void
		{
			var criterio:String = _view.txtBusca.text;
			var usuario:UsuarioDTO = new UsuarioDTO;
			
			usuario.nome = criterio;
			usuario.email = criterio;
			
			_usuarioService.addEventListener("resultSearch", buscarHandler);
			_usuarioService.findByNomeOuEmail(usuario);
		}
		
		private function buscarHandler(event:CustomEvent):void
		{
			_usuariosPesquisados = event.data;
			_view.tblBusca.dataProvider = _usuariosPesquisados;
		}
		
		public function fecharPopup():void
		{
			PopUpManager.removePopUp(_view);
		}
		
		public function teste(event:DragEvent):void
		{
			var lista:ArrayCollection = _view.tblCompartilhados.dataProvider as ArrayCollection;
			var obj:Object = event.dragInitiator;
			
			if (lista.contains(obj)) {
				Alert.show("Nao");
			} else {
				Alert.show("Sim");
			}
		}
		
	}
}