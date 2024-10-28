class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.43.3"
    checksums = {
        "darwin_arm64" => "ac660a8d58fff397984e7fce9205a7567bf3e02a560335d415765c4dd4998731",
        "darwin_amd64" => "4fdcb0cb86be5f6d14261227cfa96e64c169ece70fbe9f2a42d0fff78dc8aae1",
        "linux_arm64"  => "91071165e280b4885f7e2020306f50b4a0ac4ca0d9797f182aabf137d4b7b1cc",
        "linux_amd64"  => "99160475ef21ca0ce726ccf660ba93caa3fd9f9130d373ae7fd5ee24b9923d4d",
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
