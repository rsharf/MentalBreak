-- Verify no items have reqlevel or reclevel > 1
SELECT COUNT(*) as high_req FROM items WHERE reqlevel > 1;
SELECT COUNT(*) as high_rec FROM items WHERE reclevel > 1;
