package br.edu.ucb.webdatamodeling.service
{
	import br.edu.ucb.webdatamodeling.dto.ArquivoDTO;
	import br.edu.ucb.webdatamodeling.events.CustomEvent;
	
	import flash.events.EventDispatcher;
	
	import mx.messaging.ChannelSet;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	public class ArquivoService extends EventDispatcher
	{
		
		private var _remoteObject:RemoteObject;
        private static var _instance:ArquivoService;
        
		public function ArquivoService()
		{
			super();
            _remoteObject = new RemoteObject();
            _remoteObject.showBusyCursor = true;
            _remoteObject.destination = "ArquivoService";
            _remoteObject.channelSet = new ChannelSet(['webdatamodeling-amf']);
            _remoteObject.showBusyCursor = false;
            return;
		}

        public function insert(arquivo:ArquivoDTO):void
        {
			_remoteObject.addEventListener("result", insertHandler);
			_remoteObject.insert(arquivo);
        }
        
        private function insertHandler(event:ResultEvent):void
        {
			dispatchEvent(new CustomEvent("insert", event.result));
        }
        
        public function update(arquivo:ArquivoDTO):void
        {
			_remoteObject.addEventListener("result", updateHandler);
			_remoteObject.update(arquivo);
        }
        
        private function updateHandler(event:ResultEvent):void
        {
			dispatchEvent(new CustomEvent("update", event.result));
        }
        
        public function gerarArquivoParaExportacao(nomeArquivo:String, script:String):void
        {
			_remoteObject.addEventListener("result", gerarArquivoParaExportacaoHandler);
			_remoteObject.gerarArquivoParaExportacao(nomeArquivo, script);
        }
        
        private function gerarArquivoParaExportacaoHandler(event:ResultEvent):void
        {
			dispatchEvent(new CustomEvent("exportarArquivo", event.result));
        }
        
        public static function getInstance():ArquivoService
        {
            if (_instance == null) 
            {
                _instance = new ArquivoService();
            }
            return _instance;
        }

	}
}