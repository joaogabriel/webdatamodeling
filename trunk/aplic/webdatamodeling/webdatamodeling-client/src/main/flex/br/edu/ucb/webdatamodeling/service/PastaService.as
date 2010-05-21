package br.edu.ucb.webdatamodeling.service
{
	import br.edu.ucb.webdatamodeling.dto.PastaDTO;
	import br.edu.ucb.webdatamodeling.events.CustomEvent;
	
	import flash.events.EventDispatcher;
	
	import mx.messaging.ChannelSet;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	public class PastaService extends EventDispatcher
	{
		private var _remoteObject:RemoteObject;
        private static var _instance:PastaService;
        
		public function PastaService()
		{
			super();
            _remoteObject = new RemoteObject();
            _remoteObject.showBusyCursor = true;
            _remoteObject.destination = "PastaService";
            _remoteObject.channelSet = new ChannelSet(['webdatamodeling-amf']);
            _remoteObject.showBusyCursor = false;
            return;
		}

        public function insert(pasta:PastaDTO):void
        {
        	_remoteObject.addEventListener("result", insertHandler);
        	_remoteObject.insert(pasta);
        }
        
        public function insertHandler(event:ResultEvent):void
        {
            dispatchEvent(new CustomEvent("insert", event.result));
        }
        
		public function getPastasByUsuarioAutenticado():void
		{
			_remoteObject.addEventListener("result", getPastasByUsuarioAutenticadoHandler);
        	_remoteObject.getPastasByUsuarioAutenticado();
		}
		
		public function getPastasByUsuarioAutenticadoHandler(event:ResultEvent):void
		{
			dispatchEvent(new CustomEvent("getPastas", event.result));
		}
		
        public static function getInstance():PastaService
        {
            if (_instance == null) 
            {
                _instance = new PastaService();
            }
            return _instance;
        }

	}
}