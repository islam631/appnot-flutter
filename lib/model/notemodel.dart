class NoteModel {
  int? idNotes;
  String? notesTitle;
  String? notesContent;
  String? notesImage;
  int? notesUsers;

  NoteModel(
      {this.idNotes,
      this.notesTitle,
      this.notesContent,
      this.notesImage,
      this.notesUsers});

  NoteModel.fromJson(Map<String, dynamic> json) {
    idNotes = json['id_notes'];
    notesTitle = json['notes_title'];
    notesContent = json['notes_content'];
    notesImage = json['notes_image'];
    notesUsers = json['notes_users'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_notes'] = this.idNotes;
    data['notes_title'] = this.notesTitle;
    data['notes_content'] = this.notesContent;
    data['notes_image'] = this.notesImage;
    data['notes_users'] = this.notesUsers;
    return data;
  }
}
