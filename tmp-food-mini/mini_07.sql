DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: زرشک‌پلو با مرغ (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('زرشک‌پلو با مرغ', 'compound', 'lunch', NULL, 'lunch:6:زرشکپلو-با-مرغ', 'زرشک بدون شکر؛ روغن درج‌شده، کل سهم روغن وعده است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 450 cal, 45g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'زرشک‌پلو با مرغ — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 45,
    'lunch:6:زرشکپلو-با-مرغ:450', '[{"name":"مرغ پخته","amount":"۱۲۰ گرم","household":"۱ کف دست بزرگ"},{"name":"برنج","amount":"۸۵ گرم","household":"۸½ قاشق سرصاف"},{"name":"زرشک خشک","amount":"۵ گرم","household":"۱ قاشق غذاخوری کم‌پُر"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 46g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'زرشک‌پلو با مرغ — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 46,
    'lunch:6:زرشکپلو-با-مرغ:500', '[{"name":"مرغ پخته","amount":"۱۲۰ گرم","household":null},{"name":"برنج","amount":"۱۲۵ گرم","household":"۱۲½ قاشق سرصاف"},{"name":"زرشک خشک","amount":"۵ گرم","household":null},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 47g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'زرشک‌پلو با مرغ — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 47,
    'lunch:6:زرشکپلو-با-مرغ:550', '[{"name":"مرغ پخته","amount":"۱۲۰ گرم","household":null},{"name":"برنج","amount":"۱۶۵ گرم","household":"۱۶½ قاشق سرصاف"},{"name":"زرشک خشک","amount":"۵ گرم","household":null},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ته‌چین مرغ (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ته‌چین مرغ', 'compound', 'lunch', NULL, 'lunch:7:تهچین-مرغ', 'مرغ و روغن داخل وزن ته‌چین حساب شده‌اند. اندازهٔ برش به ضخامت قالب وابسته است؛ ته‌چین پرروغن یا کم‌مرغ، این کالری و پروتئین را ندارد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 180 cal, 9g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ته‌چین مرغ — 180 کالری', 'compound', 'lunch', NULL,
    v_base_id, '180 کالری', 180, 9,
    'lunch:7:تهچین-مرغ:180', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 23g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ته‌چین مرغ — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 23,
    'lunch:7:تهچین-مرغ:450', '[{"name":"ته‌چین آماده","amount":"۲۰۵ گرم","household":"۱ برش متوسط با همین وزن"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 26g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ته‌چین مرغ — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 26,
    'lunch:7:تهچین-مرغ:500', '[{"name":"ته‌چین آماده","amount":"۲۳۵ گرم","household":"۱ برش متوسط رو به بزرگ"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 28g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ته‌چین مرغ — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 28,
    'lunch:7:تهچین-مرغ:550', '[{"name":"ته‌چین آماده","amount":"۲۶۰ گرم","household":"۱ برش بزرگ"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: عدس‌پلو با گوشت چرخ‌کرده یا مرغ (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('عدس‌پلو با گوشت چرخ‌کرده یا مرغ', 'compound', 'lunch', NULL, 'lunch:8:عدسپلو-با-گوشت-چرخکرده-یا-مرغ', 'مرغ یا گوشت داخل وزن غذاست؛ جدا اضافه نمی‌شود. معادل قاشقی پلوهای مخلوط تقریبی‌تر از برنج ساده است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 165 cal, 9g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'عدس‌پلو با گوشت چرخ‌کرده یا مرغ — 165 کالری', 'compound', 'lunch', NULL,
    v_base_id, '165 کالری', 165, 9,
    'lunch:8:عدسپلو-با-گوشت-چرخکرده-یا-مرغ:165', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 165 cal, 10g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'عدس‌پلو با گوشت چرخ‌کرده یا مرغ — 165 کالری', 'compound', 'lunch', NULL,
    v_base_id, '165 کالری', 165, 10,
    'lunch:8:عدسپلو-با-گوشت-چرخکرده-یا-مرغ:165', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 25g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'عدس‌پلو با گوشت چرخ‌کرده یا مرغ — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 25,
    'lunch:8:عدسپلو-با-گوشت-چرخکرده-یا-مرغ:450', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 27g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'عدس‌پلو با گوشت چرخ‌کرده یا مرغ — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 27,
    'lunch:8:عدسپلو-با-گوشت-چرخکرده-یا-مرغ:450', '[{"name":"عدس‌پلوی مخلوط آماده","amount":"۲۲۵ گرم","household":"حدود ۲۲–۲۳ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 28g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'عدس‌پلو با گوشت چرخ‌کرده یا مرغ — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 28,
    'lunch:8:عدسپلو-با-گوشت-چرخکرده-یا-مرغ:500', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 30g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'عدس‌پلو با گوشت چرخ‌کرده یا مرغ — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 30,
    'lunch:8:عدسپلو-با-گوشت-چرخکرده-یا-مرغ:500', '[{"name":"عدس‌پلوی مخلوط آماده","amount":"۲۵۵ گرم","household":"حدود ۲۵–۲۶ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 31g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'عدس‌پلو با گوشت چرخ‌کرده یا مرغ — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 31,
    'lunch:8:عدسپلو-با-گوشت-چرخکرده-یا-مرغ:550', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 33g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'عدس‌پلو با گوشت چرخ‌کرده یا مرغ — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 33,
    'lunch:8:عدسپلو-با-گوشت-چرخکرده-یا-مرغ:550', '[{"name":"عدس‌پلوی مخلوط آماده","amount":"۲۸۵ گرم","household":"حدود ۲۸–۲۹ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
