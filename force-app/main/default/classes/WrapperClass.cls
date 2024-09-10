public with sharing class WrapperClass {
 
	public cls_urls urls;
	
	public class cls_urls {
		public String raw;	//https://images.unsplash.com/photo-1718489211836-65a20ad6bd8d?ixid=M3w2MjIxMzZ8MHwxfHJhbmRvbXx8fHx8fHx8fDE3MTkzOTY1OTN8&ixlib=rb-4.0.3
		public String full;	//https://images.unsplash.com/photo-1718489211836-65a20ad6bd8d?crop=entropy&cs=srgb&fm=jpg&ixid=M3w2MjIxMzZ8MHwxfHJhbmRvbXx8fHx8fHx8fDE3MTkzOTY1OTN8&ixlib=rb-4.0.3&q=85
		public String regular;	//https://images.unsplash.com/photo-1718489211836-65a20ad6bd8d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2MjIxMzZ8MHwxfHJhbmRvbXx8fHx8fHx8fDE3MTkzOTY1OTN8&ixlib=rb-4.0.3&q=80&w=1080
		public String small;	//https://images.unsplash.com/photo-1718489211836-65a20ad6bd8d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2MjIxMzZ8MHwxfHJhbmRvbXx8fHx8fHx8fDE3MTkzOTY1OTN8&ixlib=rb-4.0.3&q=80&w=400
		public String thumb;	//https://images.unsplash.com/photo-1718489211836-65a20ad6bd8d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2MjIxMzZ8MHwxfHJhbmRvbXx8fHx8fHx8fDE3MTkzOTY1OTN8&ixlib=rb-4.0.3&q=80&w=200
		public String small_s3;	//https://s3.us-west-2.amazonaws.com/images.unsplash.com/small/photo-1718489211836-65a20ad6bd8d
	}
	
    public static WrapperClass parse(String json){
        return (WrapperClass) System.JSON.deserialize(json, WrapperClass.class);
    }
}