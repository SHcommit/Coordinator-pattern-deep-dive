
정리.

1. AppDelegate에서 UIWindow를 세팅해줘야한다. 
    여기선 UIWindow를 통해 화면을 정의하고 ApplicationCoordinator에게 세팅한 윈도우를 주입하며 초기화한다.
    
    
2. ApplicationContainer에선
    이제 실행 할 수 있는 ViewController에 대한 모든 Coordinator를 다루게 된다.
    그리고 그 ViewController에 대한 루트 뷰도 적용시키기 위해 
    rootViewController 인스턴스가 필요하다.
    //rootViewController = UINavigationController
    
    그리고 화면 전환 할 수 있는 VC에 대한 Coordinator를 프로퍼티로 선언하고 DI 한다.
    
    여기선 Navigation을 컨테이너로 정했다.
    
    
    applicationCoordinator.start()
    앱의 window를 통해 presentation한다.
    이때 처음 시작이 예를들어 로그인 화면인지 메인 화면인지를 정한 후 시작한다.
    이때 특정 coordinator를 start한다!!
    
    그리고 일단 유일하게 첫 메인 화면인 KanjiListCoordinator를 보여주기 위해
    allKanjiListCoordinator를 start한다.

3.  allKanjiListCoordinator
    일단 유일하게 모든 칸지 리스트를 보여줄 수 있도록 하는 커디네이터다.
    메인 화면이라고 해도 무방하다.
    
    kanjiListVIewController를 소유하고 있다. 여기에 값이 들어오고 유지가 된다면 kanjiListViewController가 실행됬고 네비게이션 스택에 쌓였다는 것이다.
    kanjiListViewController의 컨테이너 뷰가 필요하다. 이는 presenter를 통해 가능하다.
    
    Coordinator를 상속받아 start()를 실행하면 그곳에 KanjiListViewController에 필요한 것들을 주입하고 presnter를 통해 실행한다.
    
