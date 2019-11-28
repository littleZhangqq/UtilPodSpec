# UtilPodSpec
项目常用的开发包，定位，富文本，和一些扩展类别等

先说Event的用法，这个相当于做了一个本地通知，使用场景如：一个商城APP，首页有个label显示用户当前的余额，商品详情页显示用户当前余额，个人中心登录之后也要显示余额，未登录的时候都是0元，登录之后要刷新的时候怎么办呢？
1，通知，登录之后告诉首页和商品详情页，调用他们addObserve的方法去刷新
2.使用Event 
event的原理是类似于通知的，只不过用了block来做这个事而已。
event是把每个事件都作为一个字典，键名是事件名，是个自己定义的宏，值是一个可变数组，数组里都是一个一个的block，使用的时候  我再首页和商品详情页的viewdidload里调用
[[Event getInstance] addEvent:@"eventName(最好是宏，string类型)" priority:EventDispatchPriorityDefault(优先级) cb:^BOOL(NSString *evt, __weak id data) {
        [weakSelf updateMineInfo];
        return YES;
    }];
    
block里面  就是当这个事件发生的时候你要执行的代码块，return的Bool值是为了确认当这个block执行完毕后你还要不要把这个block继续存着。如果返回yes那就下次发生同样的时候同样的处理方法，如果返回No那么执行一次之后就会删除这个block。
event的调动时机是在某些事件发生的时候。比如登录成功之后： [[Event getInstance] handleEvent:@“eventName” data:xxmodel];
data就是你要传过去的值。可以是任何nsobject类型

介绍一个完整的使用例子：
商品详情页：
@implementation ShopDetailViewController

- (void)viewDidLoad{
   [self initViews];
    MJWeakSelf；
    [[Event getInstance] addEvent:EVENT_UPDATE_MINEVIEW priority:EventDispatchPriorityDefault cb:^BOOL(NSString *evt, __weak UserModel *data) {
        [weakSelf updateMineInfo];
        return YES;
    }];
}

登录页的登录接口：
[request asyncTaskWithUrl:LOGIN_URL params:params successBlock:^(FWHResponseModel *baseModel) {
                LoginModel *userRecord = [LoginModel mj_objectWithKeyValues:baseModel.data];
                userRecord.isLogin = YES;
                [CommonModel shareInstance].accountNo = self.accountTextFeild.text;
                [CommonModel shareInstance].passWord = self.pwdTextFeild.text;
                [CommonModel shareInstance].loginData = [NSKeyedArchiver archivedDataWithRootObject:userRecord];
             
                [[RACScheduler mainThreadScheduler] afterDelay:1.5 schedule:^{
                     RootTabbarViewController *tabBar = [[RootTabbarViewController alloc]init];
                    [[[UIApplication sharedApplication].delegate window] setRootViewController:tabBar];
                    if ([CommonModel shareInstance].userRecord.role == 1) {
                        [[Event getInstance] handleEvent:@“eventname” data:nil];
                    }
                }];       
                
            }
        } failBlock:^(FWHResponseModel *baseModel) {
            [MBProgressHUD showMessage:baseModel.Msg];
        }]
        
   当然，触发商品详情页event使页面变化的前提是必须先创建好或者进入过商品详情页，如果没进入过那么block是加入不到存好的数组的。键值对执行的时候找不到这个block当然不会执行，所以一般都是2手准备，进入过该页面。执行刷新，未进入过。当前页面的接口去刷新。
   
