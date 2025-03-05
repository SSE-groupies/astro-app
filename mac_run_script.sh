(cd ../stars_backend_new; uvicorn database_service:app --host 127.0.0.1 --port 5000 --reload 1> "backend_log.txt" 2> "backend_error_log.txt") &
(cd ../Authentication; uvicorn auth_service:app --host 127.0.0.1 --port 5001 --reload 1> "auth_log.txt" 2> "auth_error_log.txt") &
(cd ../StarsApplication; uvicorn main:app --host 127.0.0.1 --port 8000 --reload 1> "app_log.txt" 2> "app_error_log.txt") &
(cd ../StarsFrontend/static; python3 -m http.server 3000 1> "frontend_log.txt" 2> "frontend_error_log.txt") &

echo "http://localhost:3000"

read -p "(Don't Ctrl + C!) Press any other key to quit ..." -n1 -s

sudo lsof -i :8000 -i :5000 -i :3000 -i :5001 | 
    awk 'NR > 1 {print $2}' |
    sort -u |
    while read line ; do
      kill -9 "$line"
    done

echo  "Processes terminated succesfully!"
