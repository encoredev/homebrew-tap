class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230921"
    checksums = {
        "darwin_arm64" => "a57411a3d85d5c95adbd3a14b9a27d91596012632edebdf870bbecef04903144",
        "darwin_amd64" => "193a5906372f4ff25a96bd40cbaa55daf0fac4daac8e71c75166fa45dd957641",
        "linux_arm64"  => "710278fb82c43b61f56fcbfa357a5e2bcca589c956a053d360d9482bd36ed50f",
        "linux_amd64"  => "6ae3fe0a39a7e71dde8397d2f9793955b9ac475258541a0db967345e6807d80a",
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
