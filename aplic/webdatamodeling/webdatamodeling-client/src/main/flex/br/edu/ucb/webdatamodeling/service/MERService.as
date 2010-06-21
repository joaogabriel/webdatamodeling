package br.edu.ucb.webdatamodeling.service
{
	import br.edu.ucb.webdatamodeling.dto.ArquivoDTO;
	import br.edu.ucb.webdatamodeling.dto.MerDTO;
	import br.edu.ucb.webdatamodeling.events.CustomEvent;
	
	import flash.events.EventDispatcher;
	
	import mx.messaging.ChannelSet;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	public class MERService extends EventDispatcher
	{
		private var _remoteObject:RemoteObject;
        private static var _instance:MERService;
        
		public function MERService()
		{
			super();
            _remoteObject = new RemoteObject();
            _remoteObject.showBusyCursor = true;
            _remoteObject.destination = "MerService";
            _remoteObject.channelSet = new ChannelSet(['webdatamodeling-amf']);
            _remoteObject.showBusyCursor = false;
            return;
		}
		
		public function insert(mer:MerDTO):void
        {
        	_remoteObject.addEventListener("result", insertHandler);
        	_remoteObject.insert(mer);
        }
        
        private function insertHandler(event:ResultEvent):void
        {
            dispatchEvent(new CustomEvent("insert", event.result));
        }
        
        public function update(mer:MerDTO):void
        {
        	_remoteObject.addEventListener("result", updateHandler);
        	_remoteObject.update(mer);
        }
        
        private function updateHandler(event:ResultEvent):void
        {
            dispatchEvent(new CustomEvent("update", event.result));
        }
        
        public function getMerByArquivo(arquivo:ArquivoDTO):void
        {
        	_remoteObject.addEventListener("result", getMerByArquivoHandler);
        	_remoteObject.getMerByArquivo(arquivo);
        }
        
        private function getMerByArquivoHandler(event:ResultEvent):void
        {
            dispatchEvent(new CustomEvent("getByArquivo", event.result));
            _remoteObject.removeEventListener(ResultEvent.RESULT, getMerByArquivoHandler);
        }
        
        public static function getInstance():MERService
        {
            if (_instance == null) 
            {
                _instance = new MERService();
            }
            return _instance;
        }

	}
}