## DevOps 사전 과제
---
### 과제 내용
웹 어플리케이션 spring-petclinic-data-jdbc을 kubernetes 환경에서 실행하고자 합니다.
- 빌드 스크립트, 어플리케이션 코드, kubernetes에 배포하기 위한 파일을 작성

### 요구사항
- gradle을 사용하여 어플리케이션과 도커이미지를 빌드한다.
```
./gradlew build
```
- 어플리케이션의 log는 host의 /logs 디렉토리에 적재되도록 한다. **OK**
- 정상 동작 여부를 반환하는 api를 구현하며, 10초에 한번 체크하도록 한다. 3번 연속 체크에 실패하면 어플리케이션은 restart 된다. **OK**
- 종료 시 30초 이내에 프로세스가 종료되지 않으면 SIGKILL로 강제 종료 시킨다. **OK**
- 배포 시와 scale in/out 시 유실되는 트래픽이 없어야 한다. **OK**
- 어플리케이션 프로세스는 root 계정이 아닌 uid:1000으로 실행한다. 
- DB도 kubernetes에서 실행하며 재 실행하며 재 실행 시에도 변경된 데이터는 유실되지 않도록 설정한다. **OK**
- 어플리케이션과 DB는 cluster domain을 이용하여 통신한다. **OK**
- nginx-ingress-controller를 통해 어플리케이션에 접속이 가능하다. **OK**
- namespace는 default를 사용한다. **OK**
- README.md 파일에 실행 방법을 기술한다.

### 1.프로젝트 실행 방법
- 소드 코드 다운로드

- 빌드
```
./gradlew bootBuildImage
```

- 어플리케이션 로그
1. logs 폴더 생성
```
minikube ssh
mkdir logs
```
2. persistent volume 생성
```
kubectl apply -f kubernetes/volume.yaml
```

3. nginx-ingress-controller 생성
```
minikube addons enable ingress
```
- 확인
```
kubectl get po -n kube-system
ingress-nginx-admission-create-t8rfm        0/1     Completed   0          58s
ingress-nginx-admission-patch-jvtwj         0/1     Completed   0          58s
ingress-nginx-controller-558664778f-fqfdp   0/1     Running     0          58s
```

### DOCKER_BUILDKIT=1 docker build -t sangmile/test
DOCKER_BUILDKIT=1 docker build -t sangmile/test:0.1 .