package br.edu.ucb.webdatamodeling.mail;

public enum EnumMailProperties {

	SMTP_HOST_NAME {
		public String getValue() {
			return "smtp.gmail.com";
		}
	},
	
    SMTP_HOST_PORT {
		public String getValue() {
			return "465";
		}
	},
	
    SMTP_AUTH_USER {
		public String getValue() {
			return "jg.bsiucb@gmail.com";
		}
	},
	
    SMTP_AUTH_PASSWORD {
		public String getValue() {
			return "180748.0";
		}
	},
	
	SMTP_AUTH {
		public String getValue() {
			return "true";
		}
	},
    
	TRANSPORT_PROTOCOL {
		public String getValue() {
			return "smtps";
		}
	},
	
	TYPE_HTML {
		public String getValue() {
			return "text/html";
		}
	};
	
    public abstract String getValue();
    
}
