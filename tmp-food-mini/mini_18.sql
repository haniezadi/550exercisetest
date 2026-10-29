DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: آش دوغ (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('آش دوغ', 'compound', 'dinner', NULL, 'dinner:19:آش-دوغ', 'دوغ یا ماست، نخود و برنج داخل وزن آش هستند؛ نان اضافه ندارد. حجم این نسخه نسبتاً زیاد است؛ آش پرنخود، پربرنج یا دارای گوشت، در همین وزن کالری بیشتری دارد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 70 cal, 5g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'آش دوغ — 70 کالری', 'compound', 'dinner', NULL,
    v_base_id, '70 کالری', 70, 5,
    'dinner:19:آش-دوغ:70', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 21g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'آش دوغ — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 21,
    'dinner:19:آش-دوغ:400', '[{"name":"آش دوغ آماده","amount":"۴۵۵ گرم","household":"حدود ۱¾ تا ۲ کاسهٔ کوچک"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 24g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'آش دوغ — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 24,
    'dinner:19:آش-دوغ:450', '[{"name":"آش دوغ آماده","amount":"۵۳۰ گرم","household":"کمی بیشتر از ۲ کاسهٔ کوچک"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 26g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'آش دوغ — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 26,
    'dinner:19:آش-دوغ:500', '[{"name":"آش دوغ آماده","amount":"۶۰۰ گرم","household":"حدود ۲½ کاسهٔ کوچک"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: سوپ مرغ (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('سوپ مرغ', 'compound', 'dinner', NULL, 'dinner:20:سوپ-مرغ', 'مرغ، سبزیجات و جو یا برنج داخل وزن سوپ حساب شده‌اند؛ نان اضافه ندارد. سوپ رقیق با مقدار کمی مرغ، همین میزان کالری و پروتئین را ندارد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 70 cal, 6g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سوپ مرغ — 70 کالری', 'compound', 'dinner', NULL,
    v_base_id, '70 کالری', 70, 6,
    'dinner:20:سوپ-مرغ:70', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 32g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سوپ مرغ — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 32,
    'dinner:20:سوپ-مرغ:400', '[{"name":"سوپ مرغ آماده","amount":"۴۵۰ گرم","household":"حدود ۱¾ تا ۲ کاسهٔ کوچک"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 37g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سوپ مرغ — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 37,
    'dinner:20:سوپ-مرغ:450', '[{"name":"سوپ مرغ آماده","amount":"۵۳۰ گرم","household":"کمی بیشتر از ۲ کاسهٔ کوچک"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 41g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سوپ مرغ — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 41,
    'dinner:20:سوپ-مرغ:500', '[{"name":"سوپ مرغ آماده","amount":"۶۰۰ گرم","household":"حدود ۲½ کاسهٔ کوچک"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: سالاد مرغ (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('سالاد مرغ', 'compound', 'dinner', NULL, 'dinner:22:سالاد-مرغ', 'مرغ پخته بدون پوست، سبزیجات، سس ماستی و روغن زیتون اندازه‌گیری‌شده. سبزیجات و ماست زیر جایگزین همراه ثابت هستند؛ همراه ثابت دوباره اضافه نمی‌شود. سس از همان ماست نوشته‌شده، همراه آب‌لیمو، ادویه و سبزی معطر تهیه می‌شود. ذرت، سیب‌زمینی، پنیر، مغزها و مایونز در محاسبه نیستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 46g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سالاد مرغ — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 46,
    'dinner:22:سالاد-مرغ:400', '[{"name":"مرغ پخته","amount":"۱۲۰ گرم","household":"۱ کف دست بزرگ"},{"name":"کاهو، خیار و گوجه خردشده","amount":"۲۰۰ گرم","household":"۲ لیوان یا ۱ کاسهٔ متوسط"},{"name":"ماست کم‌چرب برای سس","amount":"۱۰۰ گرم","household":"۶–۷ قاشق غذاخوری سرصاف"},{"name":"روغن زیتون","amount":"۲٫۵ گرم","household":"½ قاشق چای‌خوری"},{"name":"نان","amount":"۳۰ گرم","household":"۱ کف دست"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 47g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سالاد مرغ — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 47,
    'dinner:22:سالاد-مرغ:450', '[{"name":"مرغ پخته","amount":"۱۲۰ گرم","household":"۱ کف دست بزرگ"},{"name":"کاهو، خیار و گوجه خردشده","amount":"۲۰۰ گرم","household":"۲ لیوان یا ۱ کاسهٔ متوسط"},{"name":"ماست کم‌چرب برای سس","amount":"۱۰۰ گرم","household":"۶–۷ قاشق غذاخوری سرصاف"},{"name":"روغن زیتون","amount":"۲٫۵ گرم","household":"½ قاشق چای‌خوری"},{"name":"نان","amount":"۵۰ گرم","household":"۱⅔ کف دست"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 49g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سالاد مرغ — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 49,
    'dinner:22:سالاد-مرغ:500', '[{"name":"مرغ پخته","amount":"۱۲۰ گرم","household":"۱ کف دست بزرگ"},{"name":"کاهو، خیار و گوجه خردشده","amount":"۲۰۰ گرم","household":"۲ لیوان یا ۱ کاسهٔ متوسط"},{"name":"ماست کم‌چرب برای سس","amount":"۱۰۰ گرم","household":"۶–۷ قاشق غذاخوری سرصاف"},{"name":"روغن زیتون","amount":"۲٫۵ گرم","household":"½ قاشق چای‌خوری"},{"name":"نان","amount":"۷۰ گرم","household":"۲⅓ کف دست"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
