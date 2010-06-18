package br.edu.ucb.webdatamodeling.service
{
	import br.edu.ucb.webdatamodeling.dto.NotaDTO;
	import br.edu.ucb.webdatamodeling.events.CustomEvent;
	
	import flash.events.EventDispatcher;
	
	import mx.messaging.ChannelSet;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	public class NotaService extends EventDispatcher
	{
		private var _remoteObject:RemoteObject;
        private static var _instance:NotaService;

		public function NotaService()
		{
			super();
            _remoteObject = new RemoteObject();
            _remoteObject.showBusyCursor = true;
            _remoteObject.destination = "NotaService";
            _remoteObject.channelSet = new ChannelSet(['webdatamodeling-amf']);
            _remoteObject.showBusyCursor = false;
            return;
        }

        public function insert(nota:NotaDTO):void
        {
        	_remoteObject.showBusyCursor = true;
        	_remoteObject.addEventListener("result", insertHandler);
        	_remoteObject.insert(nota);
        }
        
        private function insertHandler(event:ResultEvent):void
        {
            _remoteObject.showBusyCursor = false;
            dispatchEvent(new CustomEvent("insert", event.result));
            _remoteObject.removeEventListener(ResultEvent.RESULT, insertHandler);
        }
        
        public function update(nota:NotaDTO):void
        {
        	_remoteObject.showBusyCursor = true;
        	_remoteObject.addEventListener("result", updateHandler);
        	_remoteObject.update(nota);
        }
        
        private function updateHandler(event:ResultEvent):void
        {
            _remoteObject.showBusyCursor = false;
            dispatchEvent(new CustomEvent("insert", event.result));
            _remoteObject.removeEventListener(ResultEvent.RESULT, updateHandler);
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
        
        public static function getInstance():NotaService
        {
            if (_instance == null) 
            {
                _instance = new NotaService();
            }
            return _instance;
        }
        
	}
}