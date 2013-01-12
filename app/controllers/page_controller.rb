class PageController < ApplicationController
    
    def home
    end
    def video
        videos = ['9GE9P56tK4o',
                  'l1711jiiRtM',
                  'qrqlP6hzofE',
                  't3i6eagpM4U',
                  'ML6oLuLecQ4',
                  
                  ]
        @video =videos.sample
        
    end
end
