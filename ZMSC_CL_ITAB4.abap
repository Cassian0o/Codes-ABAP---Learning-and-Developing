CLASS zcl_itab_nesting DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF artists_type,
             artist_id   TYPE string,
             artist_name TYPE string,
           END OF artists_type.
    TYPES artists TYPE STANDARD TABLE OF artists_type WITH KEY artist_id.
    TYPES: BEGIN OF albums_type,
             artist_id  TYPE string,
             album_id   TYPE string,
             album_name TYPE string,
           END OF albums_type.
    TYPES albums TYPE STANDARD TABLE OF albums_type WITH KEY artist_id album_id.
    TYPES: BEGIN OF songs_type,
             artist_id TYPE string,
             album_id  TYPE string,
             song_id   TYPE string,
             song_name TYPE string,
           END OF songs_type.
    TYPES songs TYPE STANDARD TABLE OF songs_type WITH KEY artist_id album_id song_id.


    TYPES: BEGIN OF song_nested_type,
             song_id   TYPE string,
             song_name TYPE string,
           END OF song_nested_type.
    TYPES: BEGIN OF album_song_nested_type,
             album_id   TYPE string,
             album_name TYPE string,
             songs      TYPE STANDARD TABLE OF song_nested_type WITH KEY song_id,
           END OF album_song_nested_type.
    TYPES: BEGIN OF artist_album_nested_type,
             artist_id   TYPE string,
             artist_name TYPE string,
             albums      TYPE STANDARD TABLE OF album_song_nested_type WITH KEY album_id,
           END OF artist_album_nested_type.
    TYPES nested_data TYPE STANDARD TABLE OF artist_album_nested_type WITH KEY artist_id.

    METHODS perform_nesting
      IMPORTING
        artists            TYPE artists
        albums             TYPE albums
        songs              TYPE songs
      RETURNING
        VALUE(nested_data) TYPE nested_data.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_itab_nesting IMPLEMENTATION.

METHOD perform_nesting.

  DATA: lt_artist_album_nested TYPE STANDARD TABLE OF artist_album_nested_type,
        ls_artist_album_nested TYPE artist_album_nested_type,
        ls_album_song_nested  TYPE album_song_nested_type,
        ls_song_nested        TYPE song_nested_type.

  FIELD-SYMBOLS: <ls_artist> TYPE artists_type,
                 <ls_album>  TYPE albums_type,
                 <ls_song>   TYPE songs_type.

  " Optimize by sorting
  SORT artists BY artist_id.
  SORT albums BY artist_id album_id.
  SORT songs BY artist_id album_id song_id.

  " Process artists
  LOOP AT artists ASSIGNING <ls_artist>.
    CLEAR: ls_artist_album_nested, ls_album_song_nested.
    ls_artist_album_nested-artist_id = <ls_artist>-artist_id.
    ls_artist_album_nested-artist_name = <ls_artist>-artist_name.

    " Process albums for the current artist
    LOOP AT albums ASSIGNING <ls_album> WHERE artist_id = <ls_artist>-artist_id.
      CLEAR: ls_album_song_nested.
      ls_album_song_nested-album_id = <ls_album>-album_id.
      ls_album_song_nested-album_name = <ls_album>-album_name.

      " Process songs for the current artist and album
      LOOP AT songs ASSIGNING <ls_song> WHERE artist_id = <ls_artist>-artist_id
                                         AND album_id = <ls_album>-album_id.
        ls_song_nested-song_id = <ls_song>-song_id.
        ls_song_nested-song_name = <ls_song>-song_name.
        APPEND ls_song_nested TO ls_album_song_nested-songs.
      ENDLOOP. " songs

      APPEND ls_album_song_nested TO ls_artist_album_nested-albums.
    ENDLOOP. " albums

    APPEND ls_artist_album_nested TO lt_artist_album_nested.
  ENDLOOP. " artists

  nested_data = lt_artist_album_nested.

ENDMETHOD.

ENDCLASS.
