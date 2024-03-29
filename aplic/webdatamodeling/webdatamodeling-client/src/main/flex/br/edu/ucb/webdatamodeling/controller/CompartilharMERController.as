package br.edu.ucb.webdatamodeling.controller
{
	import br.edu.ucb.webdatamodeling.components.CompartilharMER;
	import br.edu.ucb.webdatamodeling.dto.MerDTO;
	import br.edu.ucb.webdatamodeling.dto.UsuarioDTO;
	import br.edu.ucb.webdatamodeling.events.CustomEvent;
	import br.edu.ucb.webdatamodeling.service.MERService;
	import br.edu.ucb.webdatamodeling.service.UsuarioService;
	
	import mx.collections.ArrayCollection;
	import mx.managers.PopUpManager;
	import mx.utils.ArrayUtil;
	
	public class CompartilharMERController
	{
		private var _usuarioService:UsuarioService = UsuarioService.getInstance();
		
		private var _merService:MERService = MERService.getInstance();
		
		private var _view:CompartilharMER;
		
		[Bindable]
		private var _usuariosCompartilhados:ArrayCollection;
		
		[Bindable]
		private var _usuariosPesquisados:ArrayCollection;
		
		private var _usuarioSelecionado:UsuarioDTO;
		
		private var _mer:MerDTO;
		
		public function CompartilharMERController(view:CompartilharMER, mer:MerDTO)
		{
			_view = view;
			_mer = mer;
			
			_usuarioService.addEventListener("usuarioPossivelCompartilhamento", getUsuariosHandler);
			_usuarioService.getUsuariosPossivelCompartilhamento(_mer);
			
			if (_mer != null && _mer.usuarios != null && _mer.usuarios.length > 0)
			{
				_view.tblCompartilhados.dataProvider = _mer.usuarios;
			}
		}
		
		public function salvar():void
		{
			_mer.usuarios = _view.tblCompartilhados.dataProvider as ArrayCollection;
			
			_merService.addEventListener("update", updateHandler);
			_merService.update(_mer);
		}
		
		private function updateHandler(event:CustomEvent):void
		{
			_view.msgSucesso.visible = true;
		}
		
		private function getUsuariosHandler(event:CustomEvent):void
		{
			var resultList:ArrayCollection = event.data;
			var dataProvider:ArrayCollection = new ArrayCollection();
			
			/* for each (var usuario:UsuarioDTO in resultList)
			{
				for each (var usu:UsuarioDTO in _mer.usuarios)
				{
					if (!usuario.id == usu.id)
					{
						dataProvider.addItem(usuario);
					}
				}
			} */
			
			_view.tblBusca.dataProvider = resultList;
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
			_view.msgSucesso.visible = false;
			
			_usuariosPesquisados = event.data;
			_view.tblBusca.dataProvider = _usuariosPesquisados;
		}
		
		public function fecharPopup():void
		{
			PopUpManager.removePopUp(_view);
		}
		
	}
}