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

  -- Base food: لوبیاپلو با گوشت (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('لوبیاپلو با گوشت', 'compound', 'lunch', NULL, 'lunch:10:لوبیاپلو-با-گوشت', 'برنج، لوبیاسبز، گوشت کم‌چرب، رب و روغن کم؛ هر ۱۰۰ گرم آماده حدود ۱۶۰ کالری / ۸ گرم پروتئین. گوشت و روغن داخل وزن لوبیاپلو محاسبه شده‌اند؛ ته‌دیگ اضافه در این سهم نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 450 cal, 23g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'لوبیاپلو با گوشت — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 23,
    'lunch:10:لوبیاپلو-با-گوشت:450', '[{"name":"لوبیاپلوی مخلوط آماده","amount":"۲۳۰ گرم","household":"حدود ۲۳ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 26g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'لوبیاپلو با گوشت — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 26,
    'lunch:10:لوبیاپلو-با-گوشت:500', '[{"name":"لوبیاپلوی مخلوط آماده","amount":"۲۶۰ گرم","household":"حدود ۲۶ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 29g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'لوبیاپلو با گوشت — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 29,
    'lunch:10:لوبیاپلو-با-گوشت:550', '[{"name":"لوبیاپلوی مخلوط آماده","amount":"۲۹۵ گرم","household":"حدود ۲۹–۳۰ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: استانبولی‌پلو با مرغ یا گوشت (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('استانبولی‌پلو با مرغ یا گوشت', 'compound', 'lunch', NULL, 'lunch:11:استانبولیپلو-با-مرغ-یا-گوشت', 'برنج، گوجه یا رب، مقدار متعادل سیب‌زمینی، روغن کم و مرغ یا گوشت مخلوط‌شده. هر ۱۰۰ گرم: سیب‌زمینی، روغن و مرغ یا گوشت داخل وزن غذا حساب شده‌اند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 160 cal, 8g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'استانبولی‌پلو با مرغ یا گوشت — 160 کالری', 'compound', 'lunch', NULL,
    v_base_id, '160 کالری', 160, 8,
    'lunch:11:استانبولیپلو-با-مرغ-یا-گوشت:160', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 160 cal, 9g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'استانبولی‌پلو با مرغ یا گوشت — 160 کالری', 'compound', 'lunch', NULL,
    v_base_id, '160 کالری', 160, 9,
    'lunch:11:استانبولیپلو-با-مرغ-یا-گوشت:160', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 23g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'استانبولی‌پلو با مرغ یا گوشت — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 23,
    'lunch:11:استانبولیپلو-با-مرغ-یا-گوشت:450', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 26g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'استانبولی‌پلو با مرغ یا گوشت — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 26,
    'lunch:11:استانبولیپلو-با-مرغ-یا-گوشت:450', '[{"name":"استانبولی‌پلوی مخلوط آماده","amount":"۲۳۰ گرم","household":"حدود ۲۳ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 26g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'استانبولی‌پلو با مرغ یا گوشت — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 26,
    'lunch:11:استانبولیپلو-با-مرغ-یا-گوشت:500', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 28g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'استانبولی‌پلو با مرغ یا گوشت — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 28,
    'lunch:11:استانبولیپلو-با-مرغ-یا-گوشت:500', '[{"name":"استانبولی‌پلوی مخلوط آماده","amount":"۲۶۰ گرم","household":"حدود ۲۶ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 29g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'استانبولی‌پلو با مرغ یا گوشت — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 29,
    'lunch:11:استانبولیپلو-با-مرغ-یا-گوشت:550', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 32g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'استانبولی‌پلو با مرغ یا گوشت — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 32,
    'lunch:11:استانبولیپلو-با-مرغ-یا-گوشت:550', '[{"name":"استانبولی‌پلوی مخلوط آماده","amount":"۲۹۵ گرم","household":"حدود ۲۹–۳۰ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: باقالی‌پلو با مرغ یا گوشت (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('باقالی‌پلو با مرغ یا گوشت', 'compound', 'lunch', NULL, 'lunch:12:باقالیپلو-با-مرغ-یا-گوشت', 'یا گوشت گوسالهٔ کم‌چرب پخته: ۷۰ گرم ≈ حدود ¾ کف دست ماهیچه، گردن و گوشت گوسفندی چرب، جایگزین مستقیم گوشت کم‌چرب این محاسبه نیستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 160 cal, 5g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'باقالی‌پلو با مرغ یا گوشت — 160 کالری', 'compound', 'lunch', NULL,
    v_base_id, '160 کالری', 160, 5,
    'lunch:12:باقالیپلو-با-مرغ-یا-گوشت:160', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 40g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'باقالی‌پلو با مرغ یا گوشت — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 40,
    'lunch:12:باقالیپلو-با-مرغ-یا-گوشت:450', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 30g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'باقالی‌پلو با مرغ یا گوشت — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 30,
    'lunch:12:باقالیپلو-با-مرغ-یا-گوشت:450', '[{"name":"باقالی‌پلوی آماده","amount":"۱۳۵ گرم","household":"حدود ۱۳–۱۴ قاشق سرصاف"},{"name":"مرغ پخته","amount":"۹۰ گرم","household":"کمی کمتر از ۱ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 41g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'باقالی‌پلو با مرغ یا گوشت — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 41,
    'lunch:12:باقالیپلو-با-مرغ-یا-گوشت:500', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 31g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'باقالی‌پلو با مرغ یا گوشت — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 31,
    'lunch:12:باقالیپلو-با-مرغ-یا-گوشت:500', '[{"name":"باقالی‌پلوی آماده","amount":"۱۶۵ گرم","household":"حدود ۱۶–۱۷ قاشق سرصاف"},{"name":"مرغ پخته","amount":"۹۰ گرم یا گوشت کم‌چرب پخته: ۷۰ گرم","household":null},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 43g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'باقالی‌پلو با مرغ یا گوشت — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 43,
    'lunch:12:باقالیپلو-با-مرغ-یا-گوشت:550', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 33g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'باقالی‌پلو با مرغ یا گوشت — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 33,
    'lunch:12:باقالیپلو-با-مرغ-یا-گوشت:550', '[{"name":"باقالی‌پلوی آماده","amount":"۱۹۵ گرم","household":"حدود ۱۹–۲۰ قاشق سرصاف"},{"name":"مرغ پخته","amount":"۹۰ گرم یا گوشت کم‌چرب پخته: ۷۰ گرم","household":null},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: سبزی‌پلو با ماهی (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('سبزی‌پلو با ماهی', 'compound', 'lunch', NULL, 'lunch:13:سبزیپلو-با-ماهی', 'سبزی‌پلو بدون روغن اضافه و ماهی نسبتاً کم‌چربِ فرپز یا تابه‌ای. هر ۱۰۰ گرم ماهی پخته حدود ۱۵۰ کالری / ۲۶ گرم پروتئین. ماهی سوخاری یا ماهی چرب مثل سالمون، کالری متفاوتی دارد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 450 cal, 39g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سبزی‌پلو با ماهی — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 39,
    'lunch:13:سبزیپلو-با-ماهی:450', '[{"name":"ماهی پخته بدون استخوان","amount":"۱۲۰ گرم","household":"۱ کف دست بزرگ"},{"name":"سبزی‌پلو","amount":"۱۱۰ گرم","household":"۱۱ قاشق سرصاف"},{"name":"روغن سهم پخت","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 40g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سبزی‌پلو با ماهی — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 40,
    'lunch:13:سبزیپلو-با-ماهی:500', '[{"name":"ماهی پخته","amount":"۱۲۰ گرم","household":"۱ کف دست بزرگ"},{"name":"سبزی‌پلو","amount":"۱۵۰ گرم","household":"۱۵ قاشق سرصاف"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 41g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سبزی‌پلو با ماهی — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 41,
    'lunch:13:سبزیپلو-با-ماهی:550', '[{"name":"ماهی پخته","amount":"۱۲۰ گرم","household":"۱ کف دست بزرگ"},{"name":"سبزی‌پلو","amount":"۱۹۰ گرم","household":"۱۹ قاشق سرصاف"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ماهی با نان (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ماهی با نان', 'compound', 'lunch', NULL, 'lunch:14:ماهی-با-نان', NULL)
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 450 cal, 41g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماهی با نان — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 41,
    'lunch:14:ماهی-با-نان:450', '[{"name":"ماهی پخته بدون استخوان","amount":"۱۲۰ گرم","household":"۱ کف دست بزرگ"},{"name":"نان","amount":"۵۵ گرم","household":"کمی کمتر از ۲ کف دست"},{"name":"روغن سهم پخت","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 43g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماهی با نان — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 43,
    'lunch:14:ماهی-با-نان:500', '[{"name":"ماهی پخته","amount":"۱۲۰ گرم","household":"۱ کف دست بزرگ"},{"name":"نان","amount":"۷۵ گرم","household":"۲٫۵ کف دست"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 44g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماهی با نان — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 44,
    'lunch:14:ماهی-با-نان:550', '[{"name":"ماهی پخته","amount":"۱۲۰ گرم","household":"۱ کف دست بزرگ"},{"name":"نان","amount":"۹۵ گرم","household":"کمی بیشتر از ۳ کف دست"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: قورمه‌سبزی با برنج (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('قورمه‌سبزی با برنج', 'compound', 'lunch', NULL, 'lunch:15:قورمهسبزی-با-برنج', '۱۵۰ گرم خورشت در اینجا شامل گوشت نیست؛ گوشت جدا به آن اضافه می‌شود. روغن خورشت در برآورد لحاظ شده است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 120 cal, 4g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'قورمه‌سبزی با برنج — 120 کالری', 'compound', 'lunch', NULL,
    v_base_id, '120 کالری', 120, 4,
    'lunch:15:قورمهسبزی-با-برنج:120', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 28g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'قورمه‌سبزی با برنج — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 28,
    'lunch:15:قورمهسبزی-با-برنج:450', '[{"name":"بخش خورشتی بدون گوشت","amount":"۱۵۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"گوشت کم‌چرب پخته","amount":"۶۰ گرم","household":"کمی بیشتر از ½ کف دست"},{"name":"برنج","amount":"۹۰ گرم","household":"۹ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 29g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'قورمه‌سبزی با برنج — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 29,
    'lunch:15:قورمهسبزی-با-برنج:500', '[{"name":"بخش خورشتی بدون گوشت","amount":"۱۵۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"گوشت پخته","amount":"۶۰ گرم","household":null},{"name":"برنج","amount":"۱۳۰ گرم","household":"۱۳ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 30g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'قورمه‌سبزی با برنج — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 30,
    'lunch:15:قورمهسبزی-با-برنج:550', '[{"name":"بخش خورشتی بدون گوشت","amount":"۱۵۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"گوشت پخته","amount":"۶۰ گرم","household":null},{"name":"برنج","amount":"۱۷۰ گرم","household":"۱۷ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: قیمه با برنج (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('قیمه با برنج', 'compound', 'lunch', NULL, 'lunch:16:قیمه-با-برنج', 'اگر سیب‌زمینی می‌خواهی: حدود ۵۰ گرم سیب‌زمینی تنوری بدون روغن ≈ نصف سیب‌زمینی کوچک اضافه کن و ۳۵ گرم، یعنی ۳½ قاشق، از برنج کم کن. سیب‌زمینی سرخ‌شده نیازمند محاسبهٔ روغن جداست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 150 cal, 6g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'قیمه با برنج — 150 کالری', 'compound', 'lunch', NULL,
    v_base_id, '150 کالری', 150, 6,
    'lunch:16:قیمه-با-برنج:150', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 29g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'قیمه با برنج — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 29,
    'lunch:16:قیمه-با-برنج:450', '[{"name":"بخش خورشتی بدون گوشت","amount":"۱۵۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"گوشت کم‌چرب پخته","amount":"۶۰ گرم","household":"کمی بیشتر از ½ کف دست"},{"name":"برنج","amount":"۷۰ گرم","household":"۷ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 30g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'قیمه با برنج — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 30,
    'lunch:16:قیمه-با-برنج:500', '[{"name":"بخش خورشتی بدون گوشت","amount":"۱۵۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"گوشت پخته","amount":"۶۰ گرم","household":null},{"name":"برنج","amount":"۱۱۰ گرم","household":"۱۱ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 31g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'قیمه با برنج — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 31,
    'lunch:16:قیمه-با-برنج:550', '[{"name":"بخش خورشتی بدون گوشت","amount":"۱۵۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"گوشت پخته","amount":"۶۰ گرم","household":null},{"name":"برنج","amount":"۱۴۵ گرم","household":"۱۴½ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: خورشت فسنجان با برنج (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('خورشت فسنجان با برنج', 'compound', 'lunch', NULL, 'lunch:19:خورشت-فسنجان-با-برنج', 'فسنجان با مرغ، بدون شکر و روغن اضافه. بخش خورشتی شامل گردو، رب انار و پیاز، بدون مرغ است؛ هر ۱۰۰ گرم حدود ۲۰۰ کالری / ۴ گرم پروتئین. نکته: میزان گردو و غلظت فسنجان تأثیر زیادی بر کالری دارد؛ این برآورد برای فسنجان خیلی غلیظ، پرگردو یا شیرین معتبر نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 450 cal, 35g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خورشت فسنجان با برنج — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 35,
    'lunch:19:خورشت-فسنجان-با-برنج:450', '[{"name":"بخش خورشتی بدون مرغ","amount":"۸۰ گرم","household":"۵–۶ قاشق سرصاف"},{"name":"مرغ پخته","amount":"۸۰ گرم","household":"حدود ¾ کف دست"},{"name":"برنج","amount":"۶۰ گرم","household":"۶ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 36g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خورشت فسنجان با برنج — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 36,
    'lunch:19:خورشت-فسنجان-با-برنج:500', '[{"name":"بخش خورشتی بدون مرغ","amount":"۸۰ گرم","household":"۵–۶ قاشق سرصاف"},{"name":"مرغ پخته","amount":"۸۰ گرم","household":null},{"name":"برنج","amount":"۱۰۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 37g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خورشت فسنجان با برنج — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 37,
    'lunch:19:خورشت-فسنجان-با-برنج:550', '[{"name":"بخش خورشتی بدون مرغ","amount":"۸۰ گرم","household":"۵–۶ قاشق سرصاف"},{"name":"مرغ پخته","amount":"۸۰ گرم","household":null},{"name":"برنج","amount":"۱۴۰ گرم","household":"۱۴ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: خورشت بادمجان با برنج (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('خورشت بادمجان با برنج', 'compound', 'lunch', NULL, 'lunch:20:خورشت-بادمجان-با-برنج', 'بادمجان تنوری یا پخته با روغن کم، گوجه، رب و پیاز؛ هر ۱۵۰ گرم بخش خورشتی بدون گوشت حدود ۱۰۰ کالری / ۲ گرم پروتئین. بادمجان داخل همین ۱۵۰ گرم است، نه علاوه بر آن. برای بادمجان کامل، وزن‌کردن از معادل قاشقی دقیق‌تر است. بادمجان پرروغن کالری بیشتری دارد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 450 cal, 26g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خورشت بادمجان با برنج — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 26,
    'lunch:20:خورشت-بادمجان-با-برنج:450', '[{"name":"بخش خورشتی شامل بادمجان، بدون گوشت","amount":"۱۵۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"گوشت کم‌چرب پخته","amount":"۶۰ گرم","household":"کمی بیشتر از ½ کف دست"},{"name":"برنج","amount":"۱۰۵ گرم","household":"۱۰½ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 27g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خورشت بادمجان با برنج — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 27,
    'lunch:20:خورشت-بادمجان-با-برنج:500', '[{"name":"بخش خورشتی بدون گوشت","amount":"۱۵۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"گوشت پخته","amount":"۶۰ گرم","household":null},{"name":"برنج","amount":"۱۴۵ گرم","household":"۱۴½ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 28g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خورشت بادمجان با برنج — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 28,
    'lunch:20:خورشت-بادمجان-با-برنج:550', '[{"name":"بخش خورشتی بدون گوشت","amount":"۱۵۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"گوشت پخته","amount":"۶۰ گرم","household":null},{"name":"برنج","amount":"۱۸۰ گرم","household":"۱۸ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ماکارونی با گوشت چرخ‌کرده (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ماکارونی با گوشت چرخ‌کرده', 'compound', 'lunch', NULL, 'lunch:21:ماکارونی-با-گوشت-چرخکرده', 'گوشت و روغن داخل وزن غذا هستند. معادل پیمانه به شکل ماکارونی وابسته است؛ برای ماکارونی رشته‌ای، قاشق سرصاف معیار مناسبی نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 165 cal, 10g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماکارونی با گوشت چرخ‌کرده — 165 کالری', 'compound', 'lunch', NULL,
    v_base_id, '165 کالری', 165, 10,
    'lunch:21:ماکارونی-با-گوشت-چرخکرده:165', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 27g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماکارونی با گوشت چرخ‌کرده — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 27,
    'lunch:21:ماکارونی-با-گوشت-چرخکرده:450', '[{"name":"ماکارونی مخلوط آماده","amount":"۲۲۵ گرم","household":"حدود ۱½ پیمانه"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 30g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماکارونی با گوشت چرخ‌کرده — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 30,
    'lunch:21:ماکارونی-با-گوشت-چرخکرده:500', '[{"name":"ماکارونی مخلوط آماده","amount":"۲۵۵ گرم","household":"حدود ۱⅔ پیمانه"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 33g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماکارونی با گوشت چرخ‌کرده — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 33,
    'lunch:21:ماکارونی-با-گوشت-چرخکرده:550', '[{"name":"ماکارونی مخلوط آماده","amount":"۲۸۵ گرم","household":"حدود ۱¾ تا ۲ پیمانه"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ماکارونی با مرغ (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ماکارونی با مرغ', 'compound', 'lunch', NULL, 'lunch:22:ماکارونی-با-مرغ', 'ماکارونی، مرغ ریش‌ریش، رب، پیاز و روغن کم؛ بدون خامه و پنیر. هر ۱۰۰ گرم آماده حدود ۱۵۵ کالری / ۱۰ گرم پروتئین. مرغ داخل وزن ماکارونی حساب شده است؛ نان و ته‌دیگ اضافه در این سهم نیستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 450 cal, 29g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماکارونی با مرغ — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 29,
    'lunch:22:ماکارونی-با-مرغ:450', '[{"name":"ماکارونی مخلوط آماده","amount":"۲۴۰ گرم","household":"حدود ۱½ پیمانه"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 32g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماکارونی با مرغ — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 32,
    'lunch:22:ماکارونی-با-مرغ:500', '[{"name":"ماکارونی مخلوط آماده","amount":"۲۷۰ گرم","household":"حدود ۱¾ پیمانه"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 35g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماکارونی با مرغ — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 35,
    'lunch:22:ماکارونی-با-مرغ:550', '[{"name":"ماکارونی مخلوط آماده","amount":"۳۰۵ گرم","household":"حدود ۲ پیمانه"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: آبگوشت با نان (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('آبگوشت با نان', 'compound', 'lunch', NULL, 'lunch:24:آبگوشت-با-نان', 'بدون دنبه و با جداکردن چربی قابل‌مشاهده. مواد جدا ثبت شده‌اند؛ اگر آن‌ها را بکوبی، مجموع همین سهم‌ها مقدار گوشت‌کوبیدهٔ وعده است. نان تلیت‌شده، بخشی از همین سهم نان است؛ نانِ همراه گوشت‌کوبیده هم باید از همین مقدار برداشته شود.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 450 cal, 31g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'آبگوشت با نان — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 31,
    'lunch:24:آبگوشت-با-نان:450', '[{"name":"گوشت کم‌چرب پخته","amount":"۶۰ گرم","household":"کمی بیشتر از ½ کف دست"},{"name":"نخود و لوبیای پخته","amount":"۸۰ گرم","household":"حدود ۵–۶ قاشق سرصاف"},{"name":"سیب‌زمینی پخته","amount":"۵۰ گرم","household":"نصف سیب‌زمینی کوچک"},{"name":"آبِ آبگوشت کم‌چرب","amount":"۱۵۰ گرم","household":"۱ کاسهٔ کوچک کم‌پُر"},{"name":"نان","amount":"۲۵ گرم","household":"کمی کمتر از ۱ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 33g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'آبگوشت با نان — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 33,
    'lunch:24:آبگوشت-با-نان:500', '[{"name":"گوشت پخته","amount":"۶۰ گرم","household":null},{"name":"نخود و لوبیای پخته","amount":"۸۰ گرم","household":"۵–۶ قاشق سرصاف"},{"name":"سیب‌زمینی پخته","amount":"۵۰ گرم","household":"نصف سیب‌زمینی کوچک"},{"name":"آبِ آبگوشت کم‌چرب","amount":"۱۵۰ گرم","household":"۱ کاسهٔ کوچک کم‌پُر"},{"name":"نان","amount":"۴۵ گرم","household":"۱٫۵ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 34g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'آبگوشت با نان — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 34,
    'lunch:24:آبگوشت-با-نان:550', '[{"name":"گوشت پخته","amount":"۶۰ گرم","household":null},{"name":"نخود و لوبیای پخته","amount":"۸۰ گرم","household":"۵–۶ قاشق سرصاف"},{"name":"سیب‌زمینی پخته","amount":"۵۰ گرم","household":"نصف سیب‌زمینی کوچک"},{"name":"آبِ آبگوشت کم‌چرب","amount":"۱۵۰ گرم","household":"۱ کاسهٔ کوچک کم‌پُر"},{"name":"نان","amount":"۶۵ گرم","household":"کمی بیشتر از ۲ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: کباب کوبیده با برنج یا نان (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('کباب کوبیده با برنج یا نان', 'compound', 'lunch', NULL, 'lunch:25:کباب-کوبیده-با-برنج-یا-نان', 'کوبیده با چربی متوسط؛ هر ۱۰۰ گرم پخته حدود ۲۷۰ کالری / ۲۳ گرم پروتئین. بدون کرهٔ اضافه. با نان، پروتئین نسخه‌ها حدود ۳۰، ۳۲ و ۳۳ گرم است. هر سیخ رستورانی الزاماً ۹۰ گرم نیست؛ وزن و میزان چربی باید در نظر گرفته شوند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 450 cal, 28g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کباب کوبیده با برنج یا نان — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 28,
    'lunch:25:کباب-کوبیده-با-برنج-یا-نان:450', '[{"name":"کوبیده پخته","amount":"۹۰ گرم","household":"۱ سیخ کوچک با همین وزن پخته"},{"name":"برنج","amount":"۱۰۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"جایگزین برنج","amount":"نان ۵۰ گرم","household":"۱⅔ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 29g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کباب کوبیده با برنج یا نان — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 29,
    'lunch:25:کباب-کوبیده-با-برنج-یا-نان:500', '[{"name":"کوبیده پخته","amount":"۹۰ گرم","household":"۱ سیخ کوچک"},{"name":"برنج","amount":"۱۳۵ گرم","household":"۱۳½ قاشق سرصاف"},{"name":"جایگزین برنج","amount":"نان حدود ۷۰ گرم","household":"۲⅓ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 30g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کباب کوبیده با برنج یا نان — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 30,
    'lunch:25:کباب-کوبیده-با-برنج-یا-نان:550', '[{"name":"کوبیده پخته","amount":"۹۰ گرم","household":"۱ سیخ کوچک"},{"name":"برنج","amount":"۱۷۵ گرم","household":"۱۷½ قاشق سرصاف"},{"name":"جایگزین برنج","amount":"نان حدود ۹۰ گرم","household":"۳ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ساندویچ مرغ (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ساندویچ مرغ', 'compound', 'dinner', NULL, 'dinner:1:ساندویچ-مرغ', 'مرغ بدون پوست، بدون مایونز، پنیر و سیب‌زمینی سرخ‌شده. روغن نوشته‌شده، سهم پخت مرغ همان وعده است. سبزیجات همراه می‌توانند داخل ساندویچ قرار بگیرند. برای جایگزینی نان سنگک با نان ساندویچی، وزن و کالری روی بسته ملاک است؛ یک عدد نان ساندویچی اندازهٔ ثابتی ندارد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 38g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ مرغ — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 38,
    'dinner:1:ساندویچ-مرغ:400', '[{"name":"مرغ پخته و ریش‌ریش","amount":"۹۰ گرم","household":"کمی کمتر از ۱ کف دست"},{"name":"نان سنگک","amount":"۵۵ گرم","household":"کمی کمتر از ۲ کف دست"},{"name":"روغن","amount":"۳ گرم","household":"کمی بیشتر از ½ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 39g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ مرغ — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 39,
    'dinner:1:ساندویچ-مرغ:450', '[{"name":"مرغ پخته و ریش‌ریش","amount":"۹۰ گرم","household":"کمی کمتر از ۱ کف دست"},{"name":"نان سنگک","amount":"۷۵ گرم","household":"۲٫۵ کف دست"},{"name":"روغن","amount":"۳ گرم","household":"کمی بیشتر از ½ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 41g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ مرغ — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 41,
    'dinner:1:ساندویچ-مرغ:500', '[{"name":"مرغ پخته و ریش‌ریش","amount":"۹۰ گرم","household":"کمی کمتر از ۱ کف دست"},{"name":"نان سنگک","amount":"۹۵ گرم","household":"کمی بیشتر از ۳ کف دست"},{"name":"روغن","amount":"۳ گرم","household":"کمی بیشتر از ½ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ساندویچ تخم‌مرغ (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ساندویچ تخم‌مرغ', 'compound', 'dinner', NULL, 'dinner:2:ساندویچ-تخممرغ', 'تخم‌مرغ آب‌پز یا پخته در تابهٔ نچسب؛ بدون مایونز و پنیر.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 23g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ تخم‌مرغ — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 23,
    'dinner:2:ساندویچ-تخممرغ:400', '[{"name":"تخم‌مرغ","amount":"۲ عدد متوسط","household":null},{"name":"نان","amount":"۶۰ گرم","household":"۲ کف دست"},{"name":"روغن","amount":"۲ گرم","household":"کمی کمتر از ½ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 24g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ تخم‌مرغ — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 24,
    'dinner:2:ساندویچ-تخممرغ:450', '[{"name":"تخم‌مرغ","amount":"۲ عدد متوسط","household":null},{"name":"نان","amount":"۸۰ گرم","household":"۲⅔ کف دست"},{"name":"روغن","amount":"۲ گرم","household":"کمی کمتر از ½ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 26g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ تخم‌مرغ — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 26,
    'dinner:2:ساندویچ-تخممرغ:500', '[{"name":"تخم‌مرغ","amount":"۲ عدد متوسط","household":null},{"name":"نان","amount":"۱۰۰ گرم","household":"۳⅓ کف دست"},{"name":"روغن","amount":"۲ گرم","household":"کمی کمتر از ½ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 20 cal, nullg protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ تخم‌مرغ — 20 کالری', 'compound', 'dinner', NULL,
    v_base_id, '20 کالری', 20, NULL,
    'dinner:2:ساندویچ-تخممرغ:20', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ساندویچ تن ماهی (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ساندویچ تن ماهی', 'compound', 'dinner', NULL, 'dinner:3:ساندویچ-تن-ماهی', 'تن ماهی روغنی پس از تخلیهٔ روغن قابل‌جداشدن؛ هر ۱۰۰ گرم آبکش‌شده حدود ۱۹۰ کالری / ۲۶ گرم پروتئین. بدون مایونز و روغن اضافه. وزن خالص قوطی با وزن تنِ آبکش‌شده یکی نیست. برچسب محصول مبنای دقیق‌تر کالری است؛ آماده‌سازی کنسرو را مطابق دستور روی بسته انجام بده.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 35g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ تن ماهی — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 35,
    'dinner:3:ساندویچ-تن-ماهی:400', '[{"name":"تن ماهی آبکش‌شده","amount":"۱۰۰ گرم","household":"حدود ۱ کف دست به‌صورت تودهٔ فشرده"},{"name":"نان","amount":"۵۰ گرم","household":"۱⅔ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 37g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ تن ماهی — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 37,
    'dinner:3:ساندویچ-تن-ماهی:450', '[{"name":"تن ماهی آبکش‌شده","amount":"۱۰۰ گرم","household":"حدود ۱ کف دست به‌صورت تودهٔ فشرده"},{"name":"نان","amount":"۷۰ گرم","household":"۲⅓ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 39g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ تن ماهی — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 39,
    'dinner:3:ساندویچ-تن-ماهی:500', '[{"name":"تن ماهی آبکش‌شده","amount":"۱۰۰ گرم","household":"حدود ۱ کف دست به‌صورت تودهٔ فشرده"},{"name":"نان","amount":"۹۰ گرم","household":"۳ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ساندویچ کتلت (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ساندویچ کتلت', 'compound', 'dinner', NULL, 'dinner:4:ساندویچ-کتلت', 'کتلت فرپز یا تابه‌ای با گوشت نسبتاً کم‌چرب، سیب‌زمینی، تخم‌مرغ و روغن محدود؛ هر ۱۰۰ گرم آماده حدود ۱۸۰ کالری / ۱۰ گرم پروتئین. روغن پخت داخل وزن و کالری کتلت حساب شده است. مایونز، سیب‌زمینی سرخ‌شده و روغن اضافه در این سهم نیستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 20g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ کتلت — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 20,
    'dinner:4:ساندویچ-کتلت:400', '[{"name":"کتلت آماده","amount":"۱۲۰ گرم","household":"۲ عدد متوسطِ ۶۰ گرمی"},{"name":"نان","amount":"۴۰ گرم","household":"۱⅓ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 22g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ کتلت — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 22,
    'dinner:4:ساندویچ-کتلت:450', '[{"name":"کتلت آماده","amount":"۱۲۰ گرم","household":"۲ عدد متوسطِ ۶۰ گرمی"},{"name":"نان","amount":"۶۰ گرم","household":"۲ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 24g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ساندویچ کتلت — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 24,
    'dinner:4:ساندویچ-کتلت:500', '[{"name":"کتلت آماده","amount":"۱۲۰ گرم","household":"۲ عدد متوسطِ ۶۰ گرمی"},{"name":"نان","amount":"۸۰ گرم","household":"۲⅔ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  
END $$;;
