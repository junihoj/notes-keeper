class CloudStorageException implements Exception {
  const CloudStorageException();
}

class CouldNotCreateNoteException extends CloudStorageException {}

class CouldNoteGetAllNotesException extends CloudStorageException {}

class CouldNoteUpdateNoteException extends CloudStorageException {}

class CouldNoteDeleteNoteException extends CloudStorageException {}
