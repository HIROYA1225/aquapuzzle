import SwiftUI
import FirebaseFirestore

//ログインユーザ情報保持クラス
class LoginUserInfo: ObservableObject {
    //ユーザ情報usersコレクション
    @Published var userName = ""
    @Published var createDate: Timestamp?
    @Published var updateDate: Timestamp?
}

