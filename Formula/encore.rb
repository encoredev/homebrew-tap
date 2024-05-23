class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.37.6"
    checksums = {
        "darwin_arm64" => "732b7520920d2e042a2f3e6f0b3ad2f5a6b397d9623f470d8bb94d3498549419",
        "darwin_amd64" => "81942d734b480e8e6efbe07f3e98a20ee66b7581098f2eb58c3b28171ae776a1",
        "linux_arm64"  => "918a703d36a2ec91cdd5ccc6eec7da8ebe7477fc21ed09045d06df41819493ca",
        "linux_amd64"  => "eafdbf10f9fededdeaea7d414ece4c76ccb9090df97bec15aabe95eb37389d45",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]

        bin.install_symlink Dir[libexec/"bin/*"]


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
