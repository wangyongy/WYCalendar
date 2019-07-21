@version = "1.1.1"

Pod::Spec.new do |s| 
s.name = "WYCalendar" 
s.version = @version 
s.summary = "日历控件" 
s.description = "高度定制化，支持显示节假日，闰月，农历日期等各种显示方式，支持单选，多选，开始日期和结束日期等各种选择方式的日历" 
s.homepage = "https://github.com/wangyongy/WYCalendar.git" 
s.license = "Copyright (c) 2018年 wangyong. All rights reserved."
s.author = { "wangyong" => "15889450281@163.com" } 
s.ios.deployment_target = '8.0' 
s.source = { :git => "https://github.com/wangyongy/WYCalendar.git", :tag => "v#{s.version}" } 
s.source_files = 'Calendar/**/*.{h,m,bundle}' 
s.resource     = "Calendar/WYIcons.bundle"
s.requires_arc = true 
s.framework = "UIKit" 
end