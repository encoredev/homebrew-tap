class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231008"
    checksums = {
        "darwin_arm64" => "401401941539b3120cffe01fe6fba18a6106853dcd6e3dc854d34c7d31a2f00a",
        "darwin_amd64" => "6aceefa752bfc4f301170a2a6666a74900d72e61d2585887e4ca0e70f066d3ab",
        "linux_arm64"  => "67d59dcd749dedfc1d2cf88f72d0708063fd5ce21e795f902898117271ddf229",
        "linux_amd64"  => "2ee11ec3353ec1667bd66ba9f450380074c3c19856f8676a3762dc46f46e96e7",
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
