@version = "0.0.6"

Pod::Spec.new do |s| 
s.name = "WYCalendar" 
s.version = @version 
s.summary = "日历控件" 
s.description = "高度定制化，支持单选，多选，开始日期和结束日期等各种选择方式的日历" 
s.homepage = "https://github.com/wangyongy/WYCalendar.git" 
s.license = { :type => 'MIT', :file => 'LICENSE' } 
s.author = { "wangyong" => "15889450281@163.com" } 
s.ios.deployment_target = '8.0' 
s.source = { :git => "https://github.com/wangyongy/WYCalendar.git", :tag => "v#{s.version}" } 
s.source_files = 'WYCalendar/Calendar/**/*.{h,m,bundle}' 
s.resource     = "WYCalendar/Calendar/WYIcons.bundle"
s.requires_arc = true 
s.framework = "UIKit" 
end