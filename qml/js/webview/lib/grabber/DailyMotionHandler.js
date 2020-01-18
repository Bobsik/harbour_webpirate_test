window.WebPirate_DailyMotionHandlerObject = WebPirate.inherit(WebPirate_GrabberBuilderObject, function() {
    this.playbutton = "data:image/png;base64,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";
    this.videoidrgx = /\/video\/([a-z0-9]+)/;

    this.jsondata = [ "title", "owner.username", "thumbnail_url", "duration", "stream_h264_url",
                      "stream_h264_ld_url", "stream_h264_hq_url", "stream_h264_hd_url", "stream_h264_hd1080_url" ];

    this.streamtypes = [ { name: "stream_audio_url", type: "audio" },
                         { name: "stream_h264_ld_url", type: "240p" },
                         { name: "stream_h264_url", type: "380p" },
                         { name: "stream_h264_hq_url", type: "480p" },
                         { name: "stream_h264_hd_url", type: "720p" },
                         { name: "stream_h264_hd1080_url", type: "1080p" },
                         { name: "stream_hls_url", type: "hls" },
                         { name: "stream_live_hls_url", type: "live" } ];
    this.ignite();
});

window.WebPirate_DailyMotionHandlerObject.prototype.makeVideoUrl = function(videoid) {
    return document.location.protocol + "//www.dailymotion.com/json/video/" + videoid + "?fields=" + this.jsondata.join(",");
};

window.WebPirate_DailyMotionHandlerObject.prototype.grabVideo = function(videodata) {
    WebPirate.query("#dm-main-player", function(dmplayer) {
        var data = { "title": WebPirate_Utils.escape(videodata.title),
                     "author": WebPirate_Utils.escape(videodata["owner.username"]) ,
                     "thumbnail": videodata.thumbnail_url,
                     "duration": videodata.duration };

        data.videos = new Array;

        for(var i = 0; i < this.streamtypes.length; i++) {
            var streamtype = this.streamtypes[i];
            var streamurl = videodata[streamtype.name];

            if(!streamurl)
                continue;

            data.videos.push({ "type": streamtype.type, "url": streamurl });
        }

        this.createPlayer(dmplayer, "dailymotionhandler", data, this.playbutton, videodata.thumbnail_url);
    }.bind(this));
};

window.WebPirate_DailyMotionHandlerObject.prototype.getVideo = function() {
    if(!WebPirate.isDomain("dailymotion.com"))
        return false;

    WebPirate.capture(this.videoidrgx, document.location.pathname, function(videoid) {
        WebPirate.get(this.makeVideoUrl(videoid), this.grabVideo.bind(this), null, null, "json");
    }.bind(this));

    return true;
};

window.WebPirate_DailyMotionHandler = new window.WebPirate_DailyMotionHandlerObject();