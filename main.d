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
            auto rawHtml=get(url);
            this.rawHtml=to!string(rawHtml);
        }

        void EnumerateAllUrl()
        {
            //Extract strings from HTML
            urlListArr=split(rawHtml,"\"");
            
            //Leave only http or https
            import std.algorithm;
            string [] arr=urlListArr;
            for(int i=0;i<arr.length;i++)
            {
                //delete none-url strings and url in the comments
                if(!canFind(arr[i],"http") || canFind(arr[i],"<!--"))
                    arr[i]="";
            }

            //remove spaced elements
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
        string rawHtml;
        string [] urlListArr;
}

void main()
{
    auto ph = new PaserHtml("https://dlang.org/library/std/algorithm/iteration/splitter.html");
    ph.EnumerateAllUrl();

    for(int i=0;i<ph.urlList.length;i++)
    {
        writeln(i);
        writeln(ph.urlList[i]);   
    }
}

