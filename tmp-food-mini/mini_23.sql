DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: پاپ‌کورن بدون روغن (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('پاپ‌کورن بدون روغن', 'compound', 'snack', 'simple', 'snack:10:پاپکورن-بدون-روغن', 'ذرت بوداده با هوای گرم یا در ظرف مناسب، بدون روغن، کره، شکر و کارامل. هر لیوان استاندارد پاپ‌کورنِ بدون فشردن حدود ۸ گرم است. وزن‌ها مربوط به پاپ‌کورن آماده هستند، نه دانهٔ خشک ذرت.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 3g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پاپ‌کورن بدون روغن — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 3,
    'snack:10:پاپکورن-بدون-روغن:100', '[{"name":"پاپ‌کورن آماده","amount":"۲۵ گرم","household":"حدود ۳ لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 5g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پاپ‌کورن بدون روغن — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 5,
    'snack:10:پاپکورن-بدون-روغن:150', '[{"name":"پاپ‌کورن آماده","amount":"۴۰ گرم","household":"حدود ۵ لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 7g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پاپ‌کورن بدون روغن — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 7,
    'snack:10:پاپکورن-بدون-روغن:200', '[{"name":"پاپ‌کورن آماده","amount":"۵۲ گرم","household":"حدود ۶½ لیوان"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: قهوه با شیر (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('قهوه با شیر', 'compound', 'snack', 'simple', 'snack:11:قهوه-با-شیر', 'قهوهٔ ساده همراه شیر کم‌چرب؛ بدون شکر، خامه، سیروپ و پودر کافی‌میکس. حجم شیر پیش از کف‌دادن اندازه‌گیری می‌شود. تعداد شات در هر سه نسخه ثابت است؛ افزودنی‌های شیرین جدا محاسبه می‌شوند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 110 cal, 8g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'قهوه با شیر — 110 کالری', 'compound', 'snack', 'simple',
    v_base_id, '110 کالری', 110, 8,
    'snack:11:قهوه-با-شیر:110', '[{"name":"قهوهٔ دم‌شده","amount":"۳۰ میلی‌لیتر","household":"۱ شات"},{"name":"شیر کم‌چرب","amount":"۲۳۰ میلی‌لیتر","household":"۱ لیوان استاندارد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 160 cal, 12g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'قهوه با شیر — 160 کالری', 'compound', 'snack', 'simple',
    v_base_id, '160 کالری', 160, 12,
    'snack:11:قهوه-با-شیر:160', '[{"name":"قهوهٔ دم‌شده","amount":"۳۰ میلی‌لیتر","household":"۱ شات"},{"name":"شیر کم‌چرب","amount":"۳۴۵ میلی‌لیتر","household":"۱½ لیوان استاندارد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 210 cal, 16g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'قهوه با شیر — 210 کالری', 'compound', 'snack', 'simple',
    v_base_id, '210 کالری', 210, 16,
    'snack:11:قهوه-با-شیر:210', '[{"name":"قهوهٔ دم‌شده","amount":"۳۰ میلی‌لیتر","household":"۱ شات"},{"name":"شیر کم‌چرب","amount":"۴۶۰ میلی‌لیتر","household":"۲ لیوان استاندارد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: چیپس (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('چیپس', 'compound', 'snack', 'simple', 'snack:1:چیپس', 'چیپس سیب‌زمینی معمولی با حدود ۵۳۰ کالری / ۶ گرم پروتئین در ۱۰۰ گرم. ضخامت و اندازهٔ برش‌ها متفاوت است؛ وزن و برچسب بسته ملاک هستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'چیپس — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 1,
    'snack:1:چیپس:100', '[{"name":"چیپس","amount":"۱۹ گرم","household":"حدود ۱ مشت کوچک، بدون فشردن"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'چیپس — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 2,
    'snack:1:چیپس:150', '[{"name":"چیپس","amount":"۲۸ گرم","household":"حدود ۱½ مشت کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'چیپس — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 2,
    'snack:1:چیپس:200', '[{"name":"چیپس","amount":"۳۸ گرم","household":"حدود ۲ مشت کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
