import std.stdio;
import std.net.curl;
import std.conv;
import std.algorithm.searching;
import std.array;

//Class instance is specified for one website.
class PaserHtml
{ 
    public:
        this(string url)
        {
            //urlListArr = new string[0];
            GetHtml(url);
        }

        string ExtractString(string begin,string end)
        {
            return "";
        }

        void EnumerateAllUrl()
        {
            //Extract strings from HTML
            urlListArr=split(rawHtml,"\"");
            
            //Leave only http or https
            import std.algorithm;
            for(int i=0;i<urlListArr.length;i++)
            {
                if(!canFind(urlListArr[i],"http"))
                    urlListArr[i]="";
            }
            auto arr=urlListArr;
            urlListArr.length=0;
            
            for(int i=0;i<arr.length;i++)
            {
                if(arr[i]!=""){
                    urlListArr.length++;
                    urlListArr[urlListArr.length-1]=arr[i];
                }
            }
        }

        //Getter
        auto html()
        {
            return rawHtml;
        }

        auto urlList()
        {
            return this.urlListArr;
        }

    private:
        void GetHtml(string url)
        {
            auto rawHtml=get(url);
            this.rawHtml=to!string(rawHtml);
        }

    private:
        string rawHtml;
        string [] urlListArr;
}

void main()
{
    auto ph = new PaserHtml("https://dlang.org/library/std/algorithm/iteration/splitter.html");
    ph.EnumerateAllUrl();
    for(int i=0;i<ph.urlList.length;i++)
    {
        //if(ph.urlList[i]== "https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js")
        //if(canFind(ph.urlList[i],"http"))
        writeln(ph.urlList[i]);
        
    }
}

