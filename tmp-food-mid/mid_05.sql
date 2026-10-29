DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  
  -- Base food: کشک بادمجان با نان (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('کشک بادمجان با نان', 'compound', 'dinner', NULL, 'dinner:16:کشک-بادمجان-با-نان', 'کشک و روغن محدود داخل وزن غذا حساب شده‌اند. بادمجان سرخ‌شده، گردو و پیازداغ یا نعناع‌داغ اضافه، کالری را بیشتر می‌کنند. از کشک پاستوریزه استفاده کن و دستور آماده‌سازی محصول را رعایت کن.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 110 cal, 5g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کشک بادمجان با نان — 110 کالری', 'compound', 'dinner', NULL,
    v_base_id, '110 کالری', 110, 5,
    'dinner:16:کشک-بادمجان-با-نان:110', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 19g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کشک بادمجان با نان — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 19,
    'dinner:16:کشک-بادمجان-با-نان:400', '[{"name":"کشک بادمجان آماده","amount":"۲۴۰ گرم","household":"۱۶ قاشق غذاخوری سرصاف یا حدود ۱ کاسهٔ کوچک پُر"},{"name":"نان","amount":"۲۰ گرم","household":"⅔ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 20g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کشک بادمجان با نان — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 20,
    'dinner:16:کشک-بادمجان-با-نان:450', '[{"name":"کشک بادمجان آماده","amount":"۲۴۰ گرم","household":"۱۶ قاشق غذاخوری سرصاف یا حدود ۱ کاسهٔ کوچک پُر"},{"name":"نان","amount":"۴۰ گرم","household":"۱⅓ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 22g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کشک بادمجان با نان — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 22,
    'dinner:16:کشک-بادمجان-با-نان:500', '[{"name":"کشک بادمجان آماده","amount":"۲۴۰ گرم","household":"۱۶ قاشق غذاخوری سرصاف یا حدود ۱ کاسهٔ کوچک پُر"},{"name":"نان","amount":"۶۰ گرم","household":"۲ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: میرزاقاسمی با نان (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('میرزاقاسمی با نان', 'compound', 'dinner', NULL, 'dinner:17:میرزاقاسمی-با-نان', 'تخم‌مرغ و روغن داخل وزن غذا هستند؛ جدا اضافه نمی‌شوند. میرزاقاسمی کم‌تخم‌مرغ، پروتئین کمتری دارد و نسخهٔ پرروغن کالری بیشتری خواهد داشت.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 110 cal, 5g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'میرزاقاسمی با نان — 110 کالری', 'compound', 'dinner', NULL,
    v_base_id, '110 کالری', 110, 5,
    'dinner:17:میرزاقاسمی-با-نان:110', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 19g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'میرزاقاسمی با نان — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 19,
    'dinner:17:میرزاقاسمی-با-نان:400', '[{"name":"میرزاقاسمی آماده","amount":"۲۴۰ گرم","household":"۱۶ قاشق غذاخوری سرصاف یا حدود ۱ کاسهٔ کوچک پُر"},{"name":"نان","amount":"۲۰ گرم","household":"⅔ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 20g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'میرزاقاسمی با نان — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 20,
    'dinner:17:میرزاقاسمی-با-نان:450', '[{"name":"میرزاقاسمی آماده","amount":"۲۴۰ گرم","household":"۱۶ قاشق غذاخوری سرصاف یا حدود ۱ کاسهٔ کوچک پُر"},{"name":"نان","amount":"۴۰ گرم","household":"۱⅓ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 22g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'میرزاقاسمی با نان — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 22,
    'dinner:17:میرزاقاسمی-با-نان:500', '[{"name":"میرزاقاسمی آماده","amount":"۲۴۰ گرم","household":"۱۶ قاشق غذاخوری سرصاف یا حدود ۱ کاسهٔ کوچک پُر"},{"name":"نان","amount":"۶۰ گرم","household":"۲ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: آش رشته (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('آش رشته', 'compound', 'dinner', NULL, 'dinner:18:آش-رشته', 'رشته، حبوبات، کشک و تزیین کم‌روغن داخل وزن آش حساب شده‌اند؛ نان اضافه ندارد. کشک، پیازداغ و نعناع‌داغ بیشتر از مقدار دستور مبنا، نیازمند محاسبهٔ جداگانه هستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 110 cal, 5g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'آش رشته — 110 کالری', 'compound', 'dinner', NULL,
    v_base_id, '110 کالری', 110, 5,
    'dinner:18:آش-رشته:110', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 20g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'آش رشته — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 20,
    'dinner:18:آش-رشته:400', '[{"name":"آش رشته آماده","amount":"۲۹۰ گرم","household":"حدود ۱¼ کاسهٔ کوچک"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 22g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'آش رشته — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 22,
    'dinner:18:آش-رشته:450', '[{"name":"آش رشته آماده","amount":"۳۳۵ گرم","household":"حدود ۱⅓ کاسهٔ کوچک"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 24g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'آش رشته — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 24,
    'dinner:18:آش-رشته:500', '[{"name":"آش رشته آماده","amount":"۳۸۰ گرم","household":"حدود ۱½ کاسهٔ کوچک"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

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

  -- Base food: سالاد تن ماهی (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('سالاد تن ماهی', 'compound', 'dinner', NULL, 'dinner:23:سالاد-تن-ماهی', 'تن ماهی روغنی پس از تخلیهٔ روغن، سبزیجات و سس ماستی؛ بدون روغن و مایونز اضافه. سبزیجات و ماست زیر جایگزین همراه ثابت هستند. همراه ثابت دوباره اضافه نمی‌شود. سس از ماست نوشته‌شده با آب‌لیمو و ادویه تهیه می‌شود؛ ذرت، لوبیا، سیب‌زمینی و روغن داخل قوطی در این سهم نیستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 38g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سالاد تن ماهی — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 38,
    'dinner:23:سالاد-تن-ماهی:400', '[{"name":"تن ماهی آبکش‌شده","amount":"۱۱۵ گرم","household":"کمی بیشتر از ۱ کف دست به‌صورت تودهٔ فشرده"},{"name":"کاهو، خیار و گوجه خردشده","amount":"۲۰۰ گرم","household":"۲ لیوان یا ۱ کاسهٔ متوسط"},{"name":"ماست کم‌چرب برای سس","amount":"۱۰۰ گرم","household":"۶–۷ قاشق غذاخوری سرصاف"},{"name":"نان","amount":"۳۰ گرم","household":"۱ کف دست"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 40g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سالاد تن ماهی — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 40,
    'dinner:23:سالاد-تن-ماهی:450', '[{"name":"تن ماهی آبکش‌شده","amount":"۱۱۵ گرم","household":"کمی بیشتر از ۱ کف دست به‌صورت تودهٔ فشرده"},{"name":"کاهو، خیار و گوجه خردشده","amount":"۲۰۰ گرم","household":"۲ لیوان یا ۱ کاسهٔ متوسط"},{"name":"ماست کم‌چرب برای سس","amount":"۱۰۰ گرم","household":"۶–۷ قاشق غذاخوری سرصاف"},{"name":"نان","amount":"۵۰ گرم","household":"۱⅔ کف دست"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 42g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سالاد تن ماهی — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 42,
    'dinner:23:سالاد-تن-ماهی:500', '[{"name":"تن ماهی آبکش‌شده","amount":"۱۱۵ گرم","household":"کمی بیشتر از ۱ کف دست به‌صورت تودهٔ فشرده"},{"name":"کاهو، خیار و گوجه خردشده","amount":"۲۰۰ گرم","household":"۲ لیوان یا ۱ کاسهٔ متوسط"},{"name":"ماست کم‌چرب برای سس","amount":"۱۰۰ گرم","household":"۶–۷ قاشق غذاخوری سرصاف"},{"name":"نان","amount":"۷۰ گرم","household":"۲⅓ کف دست"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: سالاد الویه با نان (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('سالاد الویه با نان', 'compound', 'dinner', NULL, 'dinner:24:سالاد-الویه-با-نان', 'مرغ، سیب‌زمینی، تخم‌مرغ و سس داخل وزن الویه حساب شده‌اند. ماست همراه ثابت جدا از ماست داخل سس است. الویهٔ پرمایونز یا تهیه‌شده با کالباس، جایگزین مستقیم این نسخه نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 150 cal, 8g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سالاد الویه با نان — 150 کالری', 'compound', 'dinner', NULL,
    v_base_id, '150 کالری', 150, 8,
    'dinner:24:سالاد-الویه-با-نان:150', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 21g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سالاد الویه با نان — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 21,
    'dinner:24:سالاد-الویه-با-نان:400', '[{"name":"الویهٔ سبک آماده","amount":"۱۸۵ گرم","household":"حدود ۱۲ قاشق غذاخوری سرصاف یا ۱ کاسهٔ کوچک"},{"name":"نان","amount":"۱۵ گرم","household":"½ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 23g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سالاد الویه با نان — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 23,
    'dinner:24:سالاد-الویه-با-نان:450', '[{"name":"الویهٔ سبک آماده","amount":"۱۸۵ گرم","household":"حدود ۱۲ قاشق غذاخوری سرصاف یا ۱ کاسهٔ کوچک"},{"name":"نان","amount":"۳۵ گرم","household":"کمی بیشتر از ۱ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 24g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سالاد الویه با نان — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 24,
    'dinner:24:سالاد-الویه-با-نان:500', '[{"name":"الویهٔ سبک آماده","amount":"۱۸۵ گرم","household":"حدود ۱۲ قاشق غذاخوری سرصاف یا ۱ کاسهٔ کوچک"},{"name":"نان","amount":"۵۵ گرم","household":"کمی کمتر از ۲ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: نان، پنیر، گردو و شیر (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('نان، پنیر، گردو و شیر', 'compound', 'dinner', NULL, 'dinner:25:نان،-پنیر،-گردو-و-شیر', 'پنیر سفید معمولی و شیر کم‌چرب. در این گزینه همراه ثابت و ماست اضافه نمی‌شود؛ شیر و سبزیجات زیر جزء خود وعده هستند. نوع پنیر، درصد چربی شیر و اندازهٔ مغز گردو بر کالری اثر دارند. پنیر خامه‌ای و شیر پرچرب، جایگزین مستقیم مواد این محاسبه نیستند. میان وعده ها: مقدارها، کالری و پروتئین تقریبی‌اند. هر لیوان استاندارد شیر ۲۳۰ میلی‌لیتر و هر کف دست نان سنگک بدون انگشتان حدود ۳۰ گرم در نظر گرفته شده است. برای محصولات بسته‌بندی‌شده، برچسب همان محصول بر این برآوردها اولویت دارد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 19g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، پنیر، گردو و شیر — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 19,
    'dinner:25:نان،-پنیر،-گردو-و-شیر:400', '[{"name":"نان","amount":"۵۵ گرم","household":"کمی کمتر از ۲ کف دست"},{"name":"پنیر سفید","amount":"۳۰ گرم","household":"۱ قوطی کبریت"},{"name":"مغز گردو","amount":"۱۰ گرم","household":"۲ مغز کامل متوسط یا ۴ نیمه"},{"name":"شیر کم‌چرب","amount":"۲۰۰ میلی‌لیتر","household":"کمی کمتر از ۱ لیوان"},{"name":"خیار و گوجه","amount":"۱۰۰ گرم","household":"۱ لیوان خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 21g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، پنیر، گردو و شیر — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 21,
    'dinner:25:نان،-پنیر،-گردو-و-شیر:450', '[{"name":"نان","amount":"۷۵ گرم","household":"۲٫۵ کف دست"},{"name":"پنیر سفید","amount":"۳۰ گرم","household":"۱ قوطی کبریت"},{"name":"مغز گردو","amount":"۱۰ گرم","household":"۲ مغز کامل متوسط یا ۴ نیمه"},{"name":"شیر کم‌چرب","amount":"۲۰۰ میلی‌لیتر","household":"کمی کمتر از ۱ لیوان"},{"name":"خیار و گوجه","amount":"۱۰۰ گرم","household":"۱ لیوان خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 23g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، پنیر، گردو و شیر — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 23,
    'dinner:25:نان،-پنیر،-گردو-و-شیر:500', '[{"name":"نان","amount":"۹۵ گرم","household":"کمی بیشتر از ۳ کف دست"},{"name":"پنیر سفید","amount":"۳۰ گرم","household":"۱ قوطی کبریت"},{"name":"مغز گردو","amount":"۱۰ گرم","household":"۲ مغز کامل متوسط یا ۴ نیمه"},{"name":"شیر کم‌چرب","amount":"۲۰۰ میلی‌لیتر","household":"کمی کمتر از ۱ لیوان"},{"name":"خیار و گوجه","amount":"۱۰۰ گرم","household":"۱ لیوان خردشده"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, nullg protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'نان، پنیر، گردو و شیر — 200 کالری', 'compound', 'dinner', NULL,
    v_base_id, '200 کالری', 200, NULL,
    'dinner:25:نان،-پنیر،-گردو-و-شیر:200', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: یک واحد میوه فصل (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('یک واحد میوه فصل', 'compound', 'snack', 'simple', 'snack:1:یک-واحد-میوه-فصل', 'هر واحد میوه حدود ۶۰ کالری دارد. گزینه‌های پاییزی ابتدا آمده‌اند: سیب، گلابی، نارنگی، پرتقال، انار، خرمالو و کیوی. وزن‌ها مربوط به قسمت خوراکی میوه، بدون پوست غیرخوراکی، هسته و ضایعات هستند. هر فهرست شامل انتخاب‌های جایگزین است؛ همهٔ میوه‌ها با هم مصرف نمی‌شوند. پروتئین با نوع میوه متفاوت است و وزن خوراکی، ملاک دقیق‌تر از اندازهٔ ظاهری است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 60 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'یک واحد میوه فصل — 60 کالری', 'compound', 'snack', 'simple',
    v_base_id, '60 کالری', 60, 1,
    'snack:1:یک-واحد-میوه-فصل:60', '[{"name":"سیب","amount":"۱۱۵ گرم","household":"۱ عدد کوچک"},{"name":"گلابی","amount":"۱۰۵ گرم","household":"۱ عدد کوچک"},{"name":"نارنگی","amount":"۱۱۵ گرم","household":"۲ عدد کوچک"},{"name":"پرتقال","amount":"۱۳۰ گرم","household":"۱ عدد متوسط"},{"name":"انار دانه‌شده","amount":"۷۰ گرم","household":"حدود ½ لیوان"},{"name":"خرمالو","amount":"۸۵ گرم","household":"۱ عدد کوچک یا نصف عدد بزرگ"},{"name":"کیوی","amount":"۱۰۰ گرم","household":"۲ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 120 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'یک واحد میوه فصل — 120 کالری', 'compound', 'snack', 'simple',
    v_base_id, '120 کالری', 120, 2,
    'snack:1:یک-واحد-میوه-فصل:120', '[{"name":"سیب","amount":"۲۳۰ گرم","household":"۲ عدد کوچک"},{"name":"گلابی","amount":"۲۱۰ گرم","household":"۲ عدد کوچک"},{"name":"نارنگی","amount":"۲۳۰ گرم","household":"۴ عدد کوچک"},{"name":"پرتقال","amount":"۲۶۰ گرم","household":"۲ عدد متوسط"},{"name":"انار دانه‌شده","amount":"۱۴۰ گرم","household":"حدود ۱ لیوان"},{"name":"خرمالو","amount":"۱۷۰ گرم","household":"۲ عدد کوچک یا ۱ عدد بزرگ"},{"name":"کیوی","amount":"۲۰۰ گرم","household":"۴ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 180 cal, 3g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'یک واحد میوه فصل — 180 کالری', 'compound', 'snack', 'simple',
    v_base_id, '180 کالری', 180, 3,
    'snack:1:یک-واحد-میوه-فصل:180', '[{"name":"سیب","amount":"۳۴۵ گرم","household":"۳ عدد کوچک"},{"name":"گلابی","amount":"۳۱۵ گرم","household":"۳ عدد کوچک"},{"name":"نارنگی","amount":"۳۴۵ گرم","household":"۶ عدد کوچک"},{"name":"پرتقال","amount":"۳۹۰ گرم","household":"۳ عدد متوسط"},{"name":"انار دانه‌شده","amount":"۲۱۰ گرم","household":"حدود ۱½ لیوان"},{"name":"خرمالو","amount":"۲۵۵ گرم","household":"۳ عدد کوچک"},{"name":"کیوی","amount":"۳۰۰ گرم","household":"۶ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
