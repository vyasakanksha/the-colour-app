import 'package:supabase/supabase.dart';

// use your own SUPABASE_URL
const String SUPABASE_URL = 'https://rjepoqecpvipmqydbxrk.supabase.co';

// use your own SUPABASE_SECRET key
const String SUPABASE_SECRET =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTY0NDA1MTE5OCwiZXhwIjoxOTU5NjI3MTk4fQ.vJE0bRVUcyFXeRGx7aMSDhYFlwio2J4KZ5sLH58csF8';

final SupabaseClient supabase = SupabaseClient(SUPABASE_URL, SUPABASE_SECRET);
