class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.58.7"
    checksums = {
        "darwin_arm64" => "1a7f942b44dc0545dc75eaea4449b9a20d8c91a4e58d32c27868cee14ae2035e",
        "darwin_amd64" => "0e26c0f948eb1b6c0aaea40bf8baeb16536599ee8505527baf17b14fefe115a4",
        "linux_arm64"  => "78e5cad05756c13f6f702f27e7ef5d8fb8c26d38f1678f41cc451b2f9d1effc5",
        "linux_amd64"  => "d70e27f55c645e78509076931cc50d468d556714c7767e69113d954534bee506",
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
