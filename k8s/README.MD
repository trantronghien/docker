
# Một số thuật ngữ:
+ **kubectl**: command line để giao tiếp với cluster
+ **Cluster Kubernetes**: 1 tập hợp nhiều node(server machine) được kết nối với nhau được và Kubernetes phân bổ để chạy các ứng dụng container.
+ **Node**: là một thành phần máy chủ tham gia vào Cluster Kubernetes
+ **Pod**: 1 node có nhiều Pod. 1 pod có thể có 1 container hoặc nhiều container cùng chạy.
+ **Container Runtimes**: là phần mềm chịu trách nhiệm chạy các container. vd: Docker sử dụng `containerd` làm Container Runtime
+ **Kubeadm**: là một công cụ dùng để cài đặt và cấu hình một Cluster Kubernetes. vd: thêm Worker Nodes vào cụm...
+ **Kubelet**: là thành phần quản lý vòng đời các pod và container trên node. Cả Master và Worker Node đều phải có
+ **Kubernetes Dashboard**: là 1 thành phần quản lý và tương tác với Cluster Kubernetes bằng giao diện web.
+ **OCI**: là tiêu chuẩn chung để chuẩn hóa các phần mềm chạy container đảm bảo được sự nhất quản của các nền tảng khác nhau. vd: `containerd` , `CRI-O` đều phát triển theo chuẩn này. 
+ **process runc**:  công cụ dòng lệnh giúp thực thi các container, tương tác với hệ điều hành theo tiêu chuẩn OCI
 
# Kubernetes Master gồm 4 thành phần
+ **API Server**: nhận các lệnh từ người dùng để `tương tác với cluster Kubernetes`
+ **Scheduler**: là thành phần `phân phối và quản lý tài nguyên trong cluster Kubernetes`. Là thành phần quyết định Pod sẽ được chạy trên node nào dự vào tài nguyên hiện có.
+ **Controler - Manager**:  điều phối và quản lý các controllers `giám sát các đối tượng trong hệ thống` (Pods, Deployments, ReplicaSets, v.v.)
+ **etcd**: `Lưu trữ` cấu hình cũng như mọi hoạt động của cluster Kubernetes

# Worker Node các thành phần:
 + Pod
 + Kubelet
 + Kube-proxy
 + Container Runtimes (không sử dụng docker nữa) thay bằng `containerd` hoặc `CRI-O`

 # thành phần cần phải cài trên Nodes:
 + Bước 1: cài container runtime. cài đặt `CRI-O`
 + Bước 2: cài Kubeadm, Kubelet, and kubectl
 + Bước 3: khởi tạo master node và lưu lại token join cluster
 + Bước 4: cài đặt `Calico network plugin`
 + Bước 5: join worker node vào cluster

