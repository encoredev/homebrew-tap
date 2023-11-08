class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231108"
    checksums = {
        "darwin_arm64" => "59846c4471c0558a62c683c9f41acda0521f5d40a81926028c5a2ea325627b9f",
        "darwin_amd64" => "a1aab5ae9e1f9b00c2271812ac7531dcf89030e582dfca9ed40f757b0c78528f",
        "linux_arm64"  => "1a48213a9385b342383fb55909f4216061baf8ba56fa9770d952760c294293a0",
        "linux_amd64"  => "cd5eb4f77f915b0dacecea39b044b344fdaf288ab73a1da5403314d6b76ff75d",
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
