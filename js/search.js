
const USE_PREBUILT_INDEX=true
const BUILD_INDEX=false

let documents
let index

function loadDocuments(callback) {
    const xhr = new XMLHttpRequest()
    xhr.open('GET', '/js/lunr-documents.json', true)
    xhr.responseType = 'json'
    
    xhr.onload = function() {
    
        const status = xhr.status
        
        if (status == 200) {
            documents = xhr.response
            console.log('Documents loaded')
            callback(null)
        } else {
            console.log('Load documents failed:' + status)
            callback(status)
        }
    };
    
    xhr.send()
};

function buildIndex() {
    console.log('Building index')
    index = lunr(function () {
        this.ref('id')
        this.field('title')
        this.field('body')

        documents.forEach(function (doc) {
            this.add(doc)
        }, this)
    })
    console.log('Index built')
}

/*
To prebuild index See: https://lunrjs.com/guides/index_prebuilding.html
*/

function loadPrebuiltIndex(callback) {
    const xhr = new XMLHttpRequest()
    xhr.open('GET', '/js/lunr-build-index.json', true)
    xhr.responseType = 'json'
    
    xhr.onload = function() {
    
        const status = xhr.status;
        
        if (status == 200) {
            index = lunr.Index.load(xhr.response)
            console.log('Prebuit index loaded')
            callback(null)
        } else {
            console.log('Loading pre-built index failed:'+status)
            callback(status)
        }
    };
    
    xhr.send()
};

function loadDocumentsAndIndex(usePrebuiltIndex, callback) {
    loadDocuments(function(err) {
        if(err) {
            callback(err)
        }
        else {
            if(usePrebuiltIndex) {
                loadPrebuiltIndex(callback)
            }
            else {
                buildIndex()
                callback()
            }
        }
    })
}

const loadType = BUILD_INDEX
function loadAndSearch() {
    loadDocumentsAndIndex(loadType, function(err) {
        if(err) {
            console.log('Loading failed')
        }
        else {
            console.log('Loading ok, now searching')
            searchIndex()    
        }
    })
}

function searchIndex() {
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    const text = urlParams.get('q')
    let results
    if(text && text.length > 0) {
        console.log("Searching for: " + text)
        results = index.search(text);
        if(results.length>0){
            console.log("Search results for:" + text)
            for (var i = 0; i < results.length; i++) {
                console.log(results[i])
                var ref = results[i]['ref']
                var url = documents[ref]['url']
                var title = documents[ref]['title']
                var body = documents[ref]['body'].substring(0,160)+'...'
                console.log(title)
            }
        } else {
            console.log("Nothing found for: " + text)
        }
    }
    else {
        results = []
        console.log('no q parameter')
    }
    showSearchResults(text, results)
}

function showSearchResults(text,results) {
    const placeHolder = document.querySelector("#searchResultsPlaceHolder");
    if(results.length > 0) {
        let html = '<h1> Content matching "' + text + '" search</h1>'
        html += '<ul id="searchResults"></ul>'
        placeHolder.innerHTML = html
        const list = placeHolder.querySelector("#searchResults");
        results.forEach(function(item) {
            const ref = item.ref
            const doc = documents[ref]
            const li = document.createElement('li')
            li.innerHTML = '<a href="'+doc.url+'">'+doc.title+'</a>'
            list.appendChild(li)
        })
    }
    else {
        const html = '<h1> No content matching "' + text + '" found</h1>'
        placeHolder.innerHTML = html
    }


}

loadAndSearch()