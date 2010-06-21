package br.edu.ucb.webdatamodeling.service
{
	import br.edu.ucb.webdatamodeling.dto.MerDTO;
	import br.edu.ucb.webdatamodeling.dto.UsuarioDTO;
	import br.edu.ucb.webdatamodeling.events.CustomEvent;
	
	import flash.events.EventDispatcher;
	
	import mx.messaging.ChannelSet;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	public class UsuarioService extends EventDispatcher
	{
		private var _remoteObject:RemoteObject;
        private static var _instance:UsuarioService;

		public function UsuarioService()
		{
			super();
            _remoteObject = new RemoteObject();
            _remoteObject.showBusyCursor = true;
            _remoteObject.destination = "UsuarioService";
            _remoteObject.channelSet = new ChannelSet(['webdatamodeling-amf']);
            _remoteObject.showBusyCursor = false;
            return;
        }

        public function insert(usuario:UsuarioDTO):void
        {
        	_remoteObject.showBusyCursor = true;
        	_remoteObject.addEventListener("result", insertHandler);
        	_remoteObject.insert(usuario);
        }
        
        private function insertHandler(event:ResultEvent):void
        {
            _remoteObject.showBusyCursor = false;
            dispatchEvent(new CustomEvent("insert", event.result));
            _remoteObject.removeEventListener(ResultEvent.RESULT, insertHandler);
        }
        
        public function update(usuario:UsuarioDTO):void
        {
        	_remoteObject.showBusyCursor = true;
        	_remoteObject.addEventListener("result", updateHandler);
        	_remoteObject.update(usuario);
        }
        
        private function updateHandler(event:ResultEvent):void
        {
            _remoteObject.showBusyCursor = false;
            dispatchEvent(new CustomEvent("insert", event.result));
            _remoteObject.removeEventListener(ResultEvent.RESULT, updateHandler);
        }
        
        public function efetuarLogin(usuario:UsuarioDTO):void
        {
        	_remoteObject.showBusyCursor = true;
        	_remoteObject.addEventListener("result", efetuarLoginHandler);
        	_remoteObject.efetuarLogin(usuario);
        }
        
        private function efetuarLoginHandler(event:ResultEvent):void
        {                   
            _remoteObject.showBusyCursor = false;
            var usuarioDTO:UsuarioDTO = event.result as UsuarioDTO;
            dispatchEvent(new CustomEvent("login", usuarioDTO));
            _remoteObject.removeEventListener(ResultEvent.RESULT, efetuarLoginHandler);
        }
        
        public function recuperarSenha(usuario:UsuarioDTO):void
        {
        	_remoteObject.showBusyCursor = true;
        	_remoteObject.addEventListener(ResultEvent.RESULT, recuperarSenhaHandler);
        	_remoteObject.recuperarSenha(usuario);
        }
        
        private function recuperarSenhaHandler(event:ResultEvent):void
        {
            dispatchEvent(new CustomEvent("recuperarSenha", event.result));
            _remoteObject.removeEventListener(ResultEvent.RESULT, recuperarSenhaHandler);
            _remoteObject.showBusyCursor = false;
        } 

        public function efetuarLogout():void
        {
        	_remoteObject.showBusyCursor = true;
        	_remoteObject.addEventListener("result", efetuarLogoutHandler);
        	_remoteObject.efetuarLogout();
        	_remoteObject.removeEventListener(ResultEvent.RESULT, efetuarLoginHandler);
        }
        
        private function efetuarLogoutHandler(event:ResultEvent):void
        {
            dispatchEvent(new CustomEvent("logout", event.result));
            _remoteObject.removeEventListener(ResultEvent.RESULT, efetuarLogoutHandler);
            _remoteObject.showBusyCursor = false;
        }
        
		public function verificarUsuarioAutenticado():void
        {
        	_remoteObject.showBusyCursor = true;
        	_remoteObject.addEventListener("result", verificarUsuarioAutenticadoHandler);
        	_remoteObject.verificarUsuarioAutenticado();
        }
        
        private function verificarUsuarioAutenticadoHandler(event:ResultEvent):void
        {
        	_remoteObject.showBusyCursor = false;
            dispatchEvent(new CustomEvent("usuarioLogado", event.result));
            _remoteObject.removeEventListener(ResultEvent.RESULT, verificarUsuarioAutenticadoHandler);
        }
        
        public function findByNomeOuEmail(usuario:UsuarioDTO):void
        {
        	_remoteObject.addEventListener("result", findByNomeOuEmailHandler);
        	_remoteObject.findByNomeOuEmail(usuario);
        }
        
        private function findByNomeOuEmailHandler(event:ResultEvent):void
        {
			dispatchEvent(new CustomEvent("resultSearch", event.result));
			_remoteObject.removeEventListener(ResultEvent.RESULT, findByNomeOuEmailHandler);
        }
        
        public function findAll():void
        {
        	_remoteObject.addEventListener("result", findAllHandler);
        	_remoteObject.findAll();
        }
        
        private function findAllHandler(event:ResultEvent):void
        {
            dispatchEvent(new CustomEvent("findAll", event.result));
            _remoteObject.removeEventListener(ResultEvent.RESULT, findAllHandler);
        }
        
        public function getUsuarioAutenticado():void
        {
        	_remoteObject.addEventListener("result", getUsuarioAutenticadoHandler);
        	_remoteObject.getUsuarioAutenticado();
        }
        
        private function getUsuarioAutenticadoHandler(event:ResultEvent):void
        {
            dispatchEvent(new CustomEvent("usuarioAutenticado", event.result));
            _remoteObject.removeEventListener(ResultEvent.RESULT, getUsuarioAutenticadoHandler);
        }
        
        
        public function getUsuariosPossivelCompartilhamento(mer:MerDTO):void
        {
        	_remoteObject.addEventListener("result", getUsuariosPossivelCompartilhamentoHandler);
        	_remoteObject.getUsuariosPossivelCompartilhamento(mer);
        }
        
        private function getUsuariosPossivelCompartilhamentoHandler(event:ResultEvent):void
        {
            dispatchEvent(new CustomEvent("usuarioPossivelCompartilhamento", event.result));
            _remoteObject.removeEventListener(ResultEvent.RESULT, getUsuariosPossivelCompartilhamentoHandler);
        }
        
        public static function getInstance():UsuarioService
        {
            if (_instance == null) 
            {
                _instance = new UsuarioService();
            }
            return _instance;
        }
        
	}
}