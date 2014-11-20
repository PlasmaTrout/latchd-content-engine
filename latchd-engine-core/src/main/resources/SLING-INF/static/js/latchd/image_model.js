function ImagesViewModel() {
    var self = this;
    self.imagelist = ko.observableArray([]);
                
    $.getJSON("/uploads/images.tidy.infinity.json").then(function(item){
        for(p in item){
            if(p.indexOf("jcr:") == -1){
                self.imagelist().push({
                    path: "/uploads/images/"+p
                });
            }
        }
    });
};

LatchD.imagemodel = new ImagesViewModel();
