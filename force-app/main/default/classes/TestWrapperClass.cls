@isTest
public class TestWrapperClass {
 @IsTest
    public static void testParse() {
        // Sample JSON string to test parsing
        String jsonString = '{' +
            '"urls": {' +
                '"raw": "https://images.unsplash.com/photo-1718489211836-65a20ad6bd8d?ixid=M3w2MjIxMzZ8MHwxfHJhbmRvbXx8fHx8fHx8fDE3MTkzOTY1OTN8&ixlib=rb-4.0.3",' +
                '"full": "https://images.unsplash.com/photo-1718489211836-65a20ad6bd8d?crop=entropy&cs=srgb&fm=jpg&ixid=M3w2MjIxMzZ8MHwxfHJhbmRvbXx8fHx8fHx8fDE3MTkzOTY1OTN8&ixlib=rb-4.0.3&q=85",' +
                '"regular": "https://images.unsplash.com/photo-1718489211836-65a20ad6bd8d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2MjIxMzZ8MHwxfHJhbmRvbXx8fHx8fHx8fDE3MTkzOTY1OTN8&ixlib=rb-4.0.3&q=80&w=1080",' +
                '"small": "https://images.unsplash.com/photo-1718489211836-65a20ad6bd8d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2MjIxMzZ8MHwxfHJhbmRvbXx8fHx8fHx8fDE3MTkzOTY1OTN8&ixlib=rb-4.0.3&q=80&w=400",' +
                '"thumb": "https://images.unsplash.com/photo-1718489211836-65a20ad6bd8d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2MjIxMzZ8MHwxfHJhbmRvbXx8fHx8fHx8fDE3MTkzOTY1OTN8&ixlib=rb-4.0.3&q=80&w=200",' +
                '"small_s3": "https://s3.us-west-2.amazonaws.com/images.unsplash.com/small/photo-1718489211836-65a20ad6bd8d"' +
            '}' +
        '}';

        // Parse the JSON string
        WrapperClass parsedWrapper = WrapperClass.parse(jsonString);

        // Validate the parsed data
        System.assertNotEquals(null, parsedWrapper, 'Parsed wrapper should not be null');
        System.assertNotEquals(null, parsedWrapper.urls, 'Parsed URLs should not be null');
        System.assertEquals('https://images.unsplash.com/photo-1718489211836-65a20ad6bd8d?ixid=M3w2MjIxMzZ8MHwxfHJhbmRvbXx8fHx8fHx8fDE3MTkzOTY1OTN8&ixlib=rb-4.0.3', parsedWrapper.urls.raw);
        System.assertEquals('https://images.unsplash.com/photo-1718489211836-65a20ad6bd8d?crop=entropy&cs=srgb&fm=jpg&ixid=M3w2MjIxMzZ8MHwxfHJhbmRvbXx8fHx8fHx8fDE3MTkzOTY1OTN8&ixlib=rb-4.0.3&q=85', parsedWrapper.urls.full);
        System.assertEquals('https://images.unsplash.com/photo-1718489211836-65a20ad6bd8d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2MjIxMzZ8MHwxfHJhbmRvbXx8fHx8fHx8fDE3MTkzOTY1OTN8&ixlib=rb-4.0.3&q=80&w=1080', parsedWrapper.urls.regular);
        System.assertEquals('https://images.unsplash.com/photo-1718489211836-65a20ad6bd8d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2MjIxMzZ8MHwxfHJhbmRvbXx8fHx8fHx8fDE3MTkzOTY1OTN8&ixlib=rb-4.0.3&q=80&w=400', parsedWrapper.urls.small);
        System.assertEquals('https://images.unsplash.com/photo-1718489211836-65a20ad6bd8d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2MjIxMzZ8MHwxfHJhbmRvbXx8fHx8fHx8fDE3MTkzOTY1OTN8&ixlib=rb-4.0.3&q=80&w=200', parsedWrapper.urls.thumb);
        System.assertEquals('https://s3.us-west-2.amazonaws.com/images.unsplash.com/small/photo-1718489211836-65a20ad6bd8d', parsedWrapper.urls.small_s3);
    }
}