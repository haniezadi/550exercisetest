DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

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

END $$;
