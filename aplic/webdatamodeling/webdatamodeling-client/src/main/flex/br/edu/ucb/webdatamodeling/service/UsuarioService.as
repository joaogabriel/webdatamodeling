package br.edu.ucb.webdatamodeling.service
{
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
        	_remoteObject.addEventListener("result", insertHandler);
        	_remoteObject.insert(usuario);
        }
        
        public function insertHandler(event:ResultEvent):void
        {
            var usuarioDTO:UsuarioDTO = event.result as UsuarioDTO;
            dispatchEvent(new CustomEvent("insert", usuarioDTO));
        }
        
        public function validarLogin(usuario:UsuarioDTO):void
        {
        	_remoteObject.addEventListener("result", validarLoginHandler);
        	_remoteObject.validarLogin(usuario);
        }
        
        public function validarLoginHandler(event:ResultEvent):void
        {                   
            var usuarioDTO:UsuarioDTO = event.result as UsuarioDTO;
            dispatchEvent(new CustomEvent("login", usuarioDTO));
        }
        
        public function recuperarSenha(usuario:UsuarioDTO):void
        {
        	_remoteObject.addEventListener(ResultEvent.RESULT, recuperarSenhaHandler);
        	_remoteObject.recuperarSenha(usuario);
        }
        
        public function recuperarSenhaHandler(event:ResultEvent):void
        {
        	var usuarioDTO:UsuarioDTO = event.result as UsuarioDTO;
            dispatchEvent(new CustomEvent("recuperarSenha", usuarioDTO));
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